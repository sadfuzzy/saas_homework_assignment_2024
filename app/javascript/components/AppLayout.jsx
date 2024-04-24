import React, { Component } from "react";

class AppLayout extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return(
      <div className="vw-100 primary-color d-flex align-items-center justify-content-center">
        <div className="jumbotron jumbotron-fluid bg-transparent">
          <div className="container secondary-color">
            <h1 className="display-4">Companies</h1>

            {this.props.children}
          </div>
        </div>
      </div>
    );
  }
}

export default AppLayout
