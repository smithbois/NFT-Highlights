import React from 'react'
import {
    BrowserRouter as Router,
    Switch,
    Route,
    Link
} from "react-router-dom";

import Landing from './components/Landing';
import Streamer from './components/Streamer';
import User from './components/User';

function App() {
  return (
    <Router>
            <Switch>
                <Route path="/streamer">
                    <Streamer />
                </Route>
                <Route path="/user">
                    <User />
                </Route>
                <Route path="/">
                    <Landing />
                </Route>
            </Switch>
    </Router>
  );
}

export default App;
