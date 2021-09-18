import React from 'react'

export default function Landing(props) {
    if (props.view != "landing") return null;

    return (
        <div className="d-flex flex-column justify-content-center align-items-center h-100">
            <img src="/logo.png" width="80%" />
            <div className="mt-3">
                <button className="btn btn-pink mr-2" onClick={() => props.setView("streamer")}>Streamer</button>
                <button className="btn btn-pink" onClick={() => props.setView("user")}>User</button>
            </div>
        </div>
    )
}
