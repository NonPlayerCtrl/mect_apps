import React, { Component } from 'react';
import { version } from '../package.json';
import './page100.css';
import {MECTdate, MECTtime, MECTlabel} from './MECTplugins';


class Page100 extends Component {

  constructor(props) {
    super(props);

    this.updateData = this.updateData.bind(this);
    this.on_INPUT_clicked = this.on_INPUT_clicked.bind(this);
    this.doWrite = this.doWrite.bind(this);

    this.state = {
        theHEARTBEAT : 0,
        theINPUT : 0,
        theOUTPUT : 0,
        readStatus : "?",
        writeStatus : "?"

    };
    this.axios = require('axios');
  }

  componentDidMount() {
    this.updateInterval = setInterval(this.updateData, 500 );
  }

  updateData() {
    let thisPage = this;

    //    root@mect /local/flash/root$ cat /tmp/update_all.json
    //    Content-Type: application/json; charset=UTF-8
    //
    //    {
    //    "theHEARTBEAT"    :"5.10",
    //    "theINPUT"        :"0",
    //    "theOUTPUT"       :"0",
    //    "PLC_Year"     :"2018",
    //    "PLC_Month"    :"4",
    //    "PLC_Day"      :"11",
    //    "PLC_Hours"    :"13",
    //    "PLC_Minutes"  :"49",
    //    "PLC_Seconds"  :"34",
    //    }



    this.axios.get("/webmi/update_all.cgi", { }, { timeout: 400 })
        .then(function (response) {

            let tmpHEARTBEAT = response.data.theHEARTBEAT; // parseFloat(response.data.theHEARTBEAT).toFixed(2);
            let tmpINPUT = response.data.theINPUT; // parseInt(response.data.theINPUT, 10);
            let tmpOUTPUT = response.data.theOUTPUT; // parseInt(response.data.theOUTPUT, 10);

            thisPage.setState({
		theHEARTBEAT : tmpHEARTBEAT ,
		theINPUT : tmpINPUT , 
		theOUTPUT : tmpOUTPUT ,
		readStatus : "OK " + response.data
	    });
	})
        .catch(function (error) {
            thisPage.setState({ readStatus: "ERROR " + error.message });
        });
  }

    componentWillUnmount() {
        clearInterval(this.updateInterval);
    }

    doWrite(params) {
        let thisPage = this;

        this.axios.get("/webmi/do_write.cgi", params, { timeout: 400 })
        .then(function (response) {
            thisPage.setState({
                writeStatus : "OK " + response.data
            });
        })
        .catch(function (error) {
            thisPage.setState({ writeStatus: "ERROR " + error.message });
        });
    }

    on_INPUT_clicked() {
	if (this.state.theINPUT == 0) {
            this.doWrite({ params: {theINPUT: 1} });
	} else {
            this.doWrite({ params: {theINPUT: 0} });
	}
    }

    render() {
        //    const renderValues = this.state.values.map(function(value, i) {
        //        return <li className="p-values">#{i}={value}</li>
        //    });
        //        <p className="p-values">{this.state.actualValue}</p>
        //        <p className="p-values">values=</p>
        //            <ol>{renderValues}</ol>

        return <div>

	    <p className="page100-style"></p>
	    <p></p>
            <p className="p-values">{this.state.theHEARTBEAT}</p>
	    <p>theINPUT <button className={(this.state.theINPUT == 0)?"button-0":"button-1"} onClick={this.on_INPUT_clicked}>{(this.state.theINPUT == 0)?"off":"ON"}</button> &lt;-- touch here</p>
	    <p>theOUTPUT <button className={(this.state.theOUTPUT == 0)?"button-0":"button-1"}>{(this.state.theOUTPUT == 0)?"off":"ON"}</button></p>

            <p className="p-title">demo-react {version} page100</p>
            <p className="p-msg">readStatus={this.state.readStatus}<br/>writeStatus={this.state.writeStatus}</p>

            </div>;
    }
}

export default Page100;
