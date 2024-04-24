class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :industry, :employee_count, :deals_min, :deals_sum
end
