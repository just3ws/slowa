import React, { Component } from "react";
import Button from "@material-ui/core/Button";
import "./App.css";

// foobar
const words = [
  "bar",
  "boa",
  "boar",
  "boo",
  "bra",
  "far",
  "fob",
  "for",
  "oaf",
  "oar",
  "of",
  "or",
  "orb",
  "rob",
  "roof"
];

class Word extends Component {
  render() {
    return (
      <Button variant="contained" color="primary">
        {this.props.value}
      </Button>
    );
  }
}

class Words extends Component {
  render() {
    return words.map(word => <Word key={word} value={word} />);
  }
}

class App extends Component {
  renderWord(w) {
    return <Word value={w} />;
  }

  render() {
    return (
      <div className="App">
        <Words />
      </div>
    );
  }
}

export default App;
