class Api::V1::CompaniesController < ApplicationController
  PAGE_LIMIT = 50

  protect_from_forgery with: :exception

  def index
    companies = Rails.cache.fetch('companies-' + params_cache_key, expires: 6.hours) {
      CompanyFilter.new(filter_params, Company.all).filter.limit(PAGE_LIMIT).to_a
    }
    render json: companies
  end

  private

  def filter_params
    params.permit(:name, :industry, 'min-employee', 'min-deal-amount')
  end

  def params_cache_key
    filter_params
      .to_h
      .to_a
      .select{ |k, v| v.present? || v.to_i > 0 }
      .sort_by(&:first)
      .join('-')
  end
end
