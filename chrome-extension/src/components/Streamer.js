import React, { useState } from 'react'

export default function Streamer() {
    const [username, setUsername] = useState();
    const [pubkey, setPubkey] = useState();

    const handleUsername = (event) => setUsername(event.target.value);
    const handlePubkey = (event) => setPubkey(event.target.value);
    const handleSubmit = (event) => console.log(username, pubkey);

    return (
        <div className="d-flex flex-column h-100">
            <h6>Register Streamer</h6>
            <form onSubmit={handleSubmit}>
                <div className="form-group">
                    <label>Username</label>
                    <input className="form-control" onChange={handleUsername} />
                </div>
                <div className="form-group">
                    <label>Public Key</label>
                    <input className="form-control" onChange={handlePubkey} />
                </div>
                <button type="submit" className="btn btn-dark">Submit</button>
            </form>
        </div>
    )
}
