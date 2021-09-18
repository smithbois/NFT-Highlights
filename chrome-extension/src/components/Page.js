import React, { useState } from 'react'

import Landing from './Landing';
import Streamer from './Streamer';
import User from './User';

export default function Page() {
    const [view, setView] = useState("landing")

    return (
        <div className="h-100">
            <Landing view={view} setView={setView} />
            <Streamer view={view} setView={setView}/>
            <User view={view} setView={setView}/>
        </div>
    )
}
