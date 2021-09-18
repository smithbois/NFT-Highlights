import React, { useState } from 'react'

import Landing from './Landing';
import Streamer from './Streamer';
import User from './User';

export default function Page() {
    const [view, setView] = useState("landing")

    return (
        <div className="h-100">
            {/* <Landing />
            <Streamer />
            <User /> */}
        </div>
    )
}
