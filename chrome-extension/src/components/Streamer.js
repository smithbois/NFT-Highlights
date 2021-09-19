import React, { useState } from 'react'
const StellarSdk = require('stellar-sdk')
const server = new StellarSdk.Server('https://horizon-testnet.stellar.org')

export default function Streamer(props) {
    const [username, setUsername] = useState();
    const [pubkey, setPubkey] = useState();
    const [price, setPrice] = useState();
    const [succ, setSucc] = useState(false);
    const [err, setErr] = useState();

    const handleUsername = (event) => setUsername(event.target.value);
    const handlePubkey = (event) => setPubkey(event.target.value);
    const handlePrice = (event) => setPrice(event.target.value);

    const handleSubmit = async (event) => {
        console.log(username, pubkey);

        const body = {
            "streamerAddress": pubkey,
            "streamerUsername": username,
            "clipPrice": parseFloat(price)
        }
        const response = await fetch('https://api.josephvitko.com/v1/highlights/streamer/add', {
            method: 'post',
            body: JSON.stringify(body),
            headers: {'Content-Type': 'application/json'}
        })
        if (response.status === 200) {
            setSucc(true);
        } else {
            setErr("An error has occurred")
        }

        console.log(await response.text())
    }

    if (props.view != "streamer") return null;

    if (succ) {
        return (
            <div className="d-flex flex-column justify-content-center align-items-center h-100">
                <h4>You are registered!</h4>
            </div>
        )
    }

    return (
        <div className="container d-flex flex-column h-100 justify-content-center">
            <h6 className="pink">Register Streamer</h6>
            <div className="form-group">
                <label>Username</label>
                <input className="form-control" onChange={handleUsername} />
            </div>
            <div className="form-group">
                <label>Public Key</label>
                <input className="form-control" onChange={handlePubkey} />
            </div> 
            <div className="form-group">
                <label>Clip Price</label>
                <input className="form-control" onChange={handlePrice} />
            </div>  
            <small className="text-danger">{err}</small>
            <button className="btn btn-pink" onClick={handleSubmit}>Submit</button>
        </div>
    )
}
