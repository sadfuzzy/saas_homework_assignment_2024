import React, { Component } from "react";
import AppLayout from "./AppLayout";
import CompanyFilter from "./CompanyFilter";
import CompanyListView from "./CompanyListView";
import Company from "./Company";
import debounce from "../helpers/debounce";
import getResource from "../helpers/getResource";

class CompaniesContainer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      companies: [],
      name: "",
      industry: "",
      'min-employee': 0,
      'min-deal-amount': 0
    };
  }

  componentDidMount() {
    this._fetchCompanies();
  }

  _fetchCompanies = debounce(() => {
    let params = "?" + ['name', 'industry', 'min-employee', 'min-deal-amount']
      .map(key => key + '=' + this.state[key]).join('&');
    const url = "/api/v1/companies" + params;

    getResource(url)
      .then((data) => {
        this.setState({ companies: data })
      })
      .catch((err) => {
        console.error('Could not fetch', err);
        this.setState({ companies: [] })
      });
  })

  _getCompanies() {
    return this.state.companies.map((company) => {
      return (
        <Company
          key={company.id}
          name={company.name}
          industry={company.industry}
          employeeCount={company.employee_count}
          dealsMin={company.deals_min}
          dealsSum={company.deals_sum} />
      )
    })
  }

  _filterAll(name, value) {
    this.setState({
      [name]: value
    }, () => {
      this._fetchCompanies();
    });
  }

  render() {
    const companies = this._getCompanies();

    return (
      <AppLayout>
        <CompanyFilter filterAll={this._filterAll.bind(this)} />
        <CompanyListView companies={companies} />
      </AppLayout>
    );
  }
}

export default CompaniesContainer
