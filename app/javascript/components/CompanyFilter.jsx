import React, { Component } from "react";

class CompanyFilter extends Component {
  constructor(props) {
    super(props);

    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e) {
    this.props.filterAll(e.target.id, e.target.value);
  }

  render() {
    return(
      <div>
        <h2>Filter</h2>
        <div>
          <label htmlFor="company-name">Company Name</label>
          <div className="input-group mb-3">
            <input onKeyUp={this.handleChange} type="text" className="form-control" id="name" value={this.props.companyName} placeholder="King Inc" />
          </div>

          <label htmlFor="industry">Industry</label>
          <div className="input-group mb-3">
            <input onKeyUp={this.handleChange} type="text" className="form-control" id="industry" value={this.props.industry} placeholder="Financial Services" />
          </div>

          <label htmlFor="min-employee">Minimum Employee Count</label>
          <div className="input-group mb-3">
            <input onKeyUp={this.handleChange} type="number" className="form-control" id="min-employee" value={this.props.minEmployee} placeholder="100" />
          </div>

          <label htmlFor="min-amount">Minimum Deal Amount</label>
          <div className="input-group mb-3">
            <input onKeyUp={this.handleChange} type="number" className="form-control" id="min-deal-amount" value={this.props.minimumDealAmount} placeholder="200" />
          </div>
        </div>
      </div>
    );
  }
}

export default CompanyFilter
