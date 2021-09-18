/*global chrome*/
import React, { useState } from 'react'
const fetch = require('node-fetch');
const StellarSdk = require('stellar-sdk')
const server = new StellarSdk.Server('https://horizon-testnet.stellar.org')

export default function User(props) {
    const cost = 100;
    const url = window.location.href

    const [pubkey, setPubkey] = useState();
    const [buyState, setBuyState] = useState("initial");

    const [transaction, setTransaction] = useState()

    const handlePubkey = (event) => setPubkey(event.target.value);

    const handleBuy = async (event) => {
        // makes a call to the backend to generate a new transaction that mints the NFT and lets the user buy it
        // TODO: get the current page url
        let body = {
            "clipperAddress": "GDRJBT4OGRFMXV6SYVUR36TCMVTTDCRU7IMMNQKJBF7Y4I4PDY4CA3PB",
            "clipUrl": "https://www.twitch.tv/adinross/clip/CallousCogentPorpoiseTheThing-WkCwSNLkoVSCnOYk?filter=clips&range=30d&sort=time"
        }
        let response = await fetch('https://api.josephvitko.com/v1/highlights/nft/mint', {
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
            setBuyState("error")
        }
        console.log(response)
    }

    const handleConfirm = async () => {
        let userKeyPair = StellarSdk.Keypair.fromSecret("SA5CEHEYCS6TV6FOJEVBHYJVL3UMDOKK5IMW6GYIFWOOGKOBAMHN3M3N")
        let tx2 = new StellarSdk.Transaction(transaction, 'Test SDF Network ; September 2015');
        tx2.sign(userKeyPair)
        console.log(tx2.toEnvelope().toXDR('base64'))
        try {
            let transactionResult = await server.submitTransaction(tx2)
            console.log(transactionResult)
            setBuyState("success")
        } catch (err) {
            console.log(err)
            setBuyState("error")
        }





    }
    const handleCancel = () => {
        props.setView("landing")
        setBuyState("initial")
    }

    if (props.view !== "user") return null;

    if (buyState === "success") {
        return (
            <div className="d-flex flex-column justify-content-center align-items-center h-100">
                <h4>Congratulations! You are now the owner of this NFT!</h4>
            </div>
        )
    }

    if (buyState === "confirm") {
        return (
            <div className="d-flex flex-column justify-content-center align-items-center h-100">
                <p>A transaction has been created, do you want to sign and confirm?</p>
                <div>
                    <button className="btn btn-dark" onClick={handleConfirm}>Confirm</button>
                    <button className="btn btn-danger" onClick={handleCancel}>Cancel</button>
                </div>
            </div>
        )
    }
    if (buyState === "error") {
        return (
            <div className="d-flex flex-column justify-content-center align-items-center h-100">
                <p>An error occurred!</p>
                <div>
                    <button className="btn btn-danger" onClick={handleCancel}>Cancel</button>
                </div>
            </div>
        )
    }

    return (
        <div className="d-flex flex-column h-100">
            <h6>Buy this clip</h6>
            <p>Cost: {cost}</p>
            <div>
                <div className="form-group">
                    <label>Public Key</label>
                    <input className="form-control" onChange={handlePubkey} />
                </div>
                <button className="btn btn-dark" onClick={handleBuy}>Buy</button>
            </div>
        </div>
    )
}

async function buildNftTransaction(setDidBuildTransactionSucceed) {

}
