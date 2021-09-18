import React, { useState } from 'react'

export default function Streamer(props) {
    const [username, setUsername] = useState();
    const [pubkey, setPubkey] = useState();
    const [succ, setSucc] = useState(false);

    const handleUsername = (event) => setUsername(event.target.value);
    const handlePubkey = (event) => setPubkey(event.target.value);
    const handleSubmit = (event) => {
        console.log(username, pubkey);
        setSucc(true);
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
        <div className="d-flex flex-column h-100">
            <h6>Register Streamer</h6>
            <div>
                <div className="form-group">
                    <label>Username</label>
                    <input className="form-control" onChange={handleUsername} />
                </div>
                <div className="form-group">
                    <label>Public Key</label>
                    <input className="form-control" onChange={handlePubkey} />
                </div>
                <button className="btn btn-dark" onClick={handleSubmit}>Submit</button>
            </div>
        </div>
    )
}
