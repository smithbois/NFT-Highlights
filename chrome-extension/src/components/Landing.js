import React from 'react'

export default function Landing(props) {
    if (props.view != "landing") return null;

    return (
        <div className="d-flex flex-column justify-content-center align-items-center h-100">
            <h4>Welcome to NFT Highlights</h4>
            <div>
                <button className="btn btn-dark" onClick={() => props.setView("streamer")}>streamer</button>
                <button className="btn btn-dark" onClick={() => props.setView("user")}>user</button>
            </div>
        </div>
    )
}
