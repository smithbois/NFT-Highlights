/*global chrome*/
import React, { useState, useEffect } from 'react'
const StellarSdk = require('stellar-sdk')
const server = new StellarSdk.Server('https://horizon-testnet.stellar.org')

export default function User(props) {
    var url = null;

    const [pubkey, setPubkey] = useState();
    const [privkey, setPrivkey] = useState();
    const [buyState, setBuyState] = useState("initial");
    const [transaction, setTransaction] = useState()
    const [cost, setCost] = useState();
    const [err, setErr] = useState();

    const handlePubkey = (event) => setPubkey(event.target.value);
    const handlePrivkey = (event) => setPrivkey(event.target.value);

    useEffect(() => {
        chrome.tabs.query({active: true, lastFocusedWindow: true}, (tabs) => {
            url = tabs[0].url
            getCost(url)
        });
    });

    const handleBuy = async (event) => {
        // makes a call to the backend to generate a new transaction that mints the NFT and lets the user buy it
        console.log (pubkey, url)

        const body = {
            "clipperAddress": pubkey,
            "clipUrl": url
        }
        const response = await fetch('https://api.josephvitko.com/v1/highlights/nft/mint', {
            method: 'post',
            body: JSON.stringify(body),
            headers: {'Content-Type': 'application/json'}
        })
        if (response.status === 200) {
            // if it succeeds, the unsigned transaction XDR should be returned.
            let xdr = await response.text()
            console.log(xdr)
            let t = StellarSdk.xdr.TransactionEnvelope.fromXDR(xdr, "base64")
            console.log(typeof t)
            setTransaction(t)
            setBuyState("confirm")
        } else {
            // if it fails, show an error.
            setErr("An error has occurred")
            console.log(await response.text())   
        }

        getBalance()
    }

    const getCost = async (url) => {
        const name = url.split("/")[3]
        const response = await fetch('https://api.josephvitko.com/v1/highlights/streamer/' + name, {
            method: 'get',
            headers: {'Content-Type': 'application/json'}
        })
        if (response.status === 200) {
            let res = await response.json()
            console.log(res.clipPrice)
            setCost(res.clipPrice)
        } else {
            // if it fails, show an error.
            setErr("An error has occurred")
            console.log(await response.text())
        }
    }

    const getBalance = async () => {
        const acc = await server.loadAccount(pubkey)
        const balance = acc.balances.filter(bal => bal.asset_type == "native")
        return balance[0].balance
    }

    const handleConfirm = async () => {
        const userKeyPair = StellarSdk.Keypair.fromSecret(privkey)
        const tx2 = new StellarSdk.Transaction(transaction, 'Test SDF Network ; September 2015');
        tx2.sign(userKeyPair)
        console.log(tx2.toEnvelope().toXDR('base64'))
        try {
            const transactionResult = await server.submitTransaction(tx2)
            console.log(transactionResult)
            setBuyState("success")
        } catch (err) {
            console.log(err)
            setErr("An error has occurred")
        }
    }

    const handleCancel = () => {
        props.setView("landing")
        setBuyState("initial")
    }

    if (buyState === "success") {
        return (
            <div className="d-flex flex-column justify-content-center align-items-center h-100">
                <p className="text-center">Congratulations! You are now the owner of this NFT!</p>
            </div>
        )
    }

    if (buyState === "confirm") {
        return (
            <div className="d-flex flex-column justify-content-center align-items-center h-100">
                <p className="text-center">A transaction has been created, sign and confirm?</p>
                <small className="text-danger">{err}</small>
                <div>
                    <button className="btn btn-success mr-2" onClick={handleConfirm}>Confirm</button>
                    <button className="btn btn-danger" onClick={handleCancel}>Cancel</button>
                </div>
            </div>
        )
    }

    return (
        <div className="container d-flex flex-column h-100 justify-content-center">
            <h6>Buy this clip</h6>
            <p>Cost: {cost}</p>
            <div className="form-group">
                <label className="pink">Public Key</label>
                <input className="form-control" onChange={handlePubkey} />
            </div>
            <div className="form-group">
                <label className="pink">Private Key</label>
                <input className="form-control" onChange={handlePrivkey} />
            </div>
            <small className="text-danger">{err}</small>
            <button className="btn btn-pink" onClick={handleBuy}>Buy</button>
        </div>
    )
}
