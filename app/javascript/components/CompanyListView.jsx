import React, { Component } from "react";

class CompanyListView extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return(
      <table className="table">
        <thead>
          <tr>
            <th scope="col">Name</th>
            <th scope="col">Industry</th>
            <th scope="col">Employee Count</th>
            <th scope="col">Minimum Deal Amount</th>
            <th scope="col">Total Deal Amount</th>
          </tr>
        </thead>
        <tbody>
          {this.props.companies}
        </tbody>
      </table>
    );
  }
}

export default CompanyListView
