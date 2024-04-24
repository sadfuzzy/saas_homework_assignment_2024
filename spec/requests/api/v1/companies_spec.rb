# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CompaniesController, type: :controller do
  describe 'GET #index' do
    let!(:company1) { create(:company, name: 'Test Company', industry: 'Tech', employee_count: 100) }
    let!(:company2) { create(:company, name: 'Another Company', industry: 'Finance', employee_count: 50) }
    let!(:deal1) { create(:deal, company: company1, status: 'won', amount: 1000) }
    let!(:deal2) { create(:deal, company: company1, status: 'lost', amount: 500) }
    let!(:deal3) { create(:deal, company: company2, status: 'won', amount: 2000) }

    context 'filter by name' do
      it 'returns companies with matching name' do
        get :index, params: { name: 'Test' }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).count).to eq(1)
        expect(JSON.parse(response.body).first['name']).to eq(company1.name)
      end
    end

    context 'filter by industry' do
      it 'returns companies with matching industry' do
        get :index, params: { industry: 'Tech' }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).count).to eq(1)
        expect(JSON.parse(response.body).first['industry']).to eq(company1.industry)
      end
    end

    context 'filter by minimum employee count' do
      it 'returns companies with more than the minimum employee count' do
        get :index, params: { 'min-employee' => 60 }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).count).to eq(1)
        expect(JSON.parse(response.body).first['employee_count']).to eq(company1.employee_count)
      end
    end

    context 'check deals sum in response' do
      it 'returns companies with correct deals sum' do
        get :index

        expect(response).to have_http_status(:success)
        response_company = JSON.parse(response.body).find { |c| c['name'] == company1.name }
        expect(response_company['deals_sum']).to eq(deal1.amount - deal2.amount)
      end
    end
  end
end
