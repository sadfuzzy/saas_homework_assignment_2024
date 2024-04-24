import React, { Component } from "react";

class Company extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return(
      <tr key={this.props.id}>
        <td>{this.props.name}</td>
        <td>{this.props.industry}</td>
        <td>{this.props.employeeCount}</td>
        <td>{this.props.dealsMin}</td>
        <td>{this.props.dealsSum}</td>
      </tr>
    );
  }
}

export default Company
