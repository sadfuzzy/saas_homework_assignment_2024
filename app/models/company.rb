class Company < ApplicationRecord
  has_many :deals

  scope :by_name, -> (name) { where('LOWER(companies.name) like ?', "%#{name.downcase}%") }
  scope :by_industry, -> (industry) { where('LOWER(companies.industry) like ?', "%#{industry.downcase}%") }
  scope :by_min_employee, -> (number) { where('companies.employee_count > ?', number.to_i) }
  scope :by_min_deal_amount, -> (amount) do
    left_outer_joins(:deals)
      .group('companies.id')
      .having('MIN(deals.amount) >= ?', amount.to_i)
  end
end
