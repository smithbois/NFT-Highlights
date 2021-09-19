import React from 'react'
import {
    Link
} from "react-router-dom";

export default function Landing(props) {
    return (
        <div className="d-flex flex-column justify-content-center align-items-center h-100">
            <img src="/logo.png" width="80%" />
            <div className="mt-3">
                <Link to="/streamer"><button className="btn btn-pink mr-2">Streamer</button></Link>
                <Link to="/user"><button className="btn btn-pink">User</button></Link>
            </div>
        </div>
    )
}
