import React, { useState } from 'react'

export default function User() {
    const cost = 100;
    const url = window.location.href
    
    const [pubkey, setPubkey] = useState();

    const handlePubkey = (event) => setPubkey(event.target.value);
    const handleSubmit = (event) => console.log(pubkey, url);

    return (
        <div className="d-flex flex-column h-100">
            <h6>Buy this clip</h6>
            <p>Cost: {cost}</p>
            <form onSubmit={handleSubmit}>
                <div className="form-group">
                    <label>Public Key</label>
                    <input className="form-control" onChange={handlePubkey} />
                </div>
                <button type="submit" className="btn btn-dark">Submit</button>
            </form>
        </div>
    )
}
