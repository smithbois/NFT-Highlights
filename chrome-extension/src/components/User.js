import React, { useState } from 'react'

export default function User(props) {
    const cost = 100;
    const url = window.location.href

    const [pubkey, setPubkey] = useState();
    const [buyState, setBuyState] = useState("initial");

    const handlePubkey = (event) => setPubkey(event.target.value);
    const handleBuy = (event) => {
        console.log(pubkey, url);
        setBuyState("confirm")
    }
    const handleConfirm = () => {
        setBuyState("success")
    }
    const handleCancel = () => {
        props.setView("landing")
        setBuyState("initial")
    }

    if (props.view != "user") return null;

    if (buyState == "success") {
        return (
            <div className="d-flex flex-column justify-content-center align-items-center h-100">
                <h4>Congratulations! You are now the owner of this NFT!</h4>
            </div>
        )
    }

    if (buyState == "confirm") {
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
