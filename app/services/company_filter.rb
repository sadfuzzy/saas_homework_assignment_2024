# frozen_string_literal: true

class CompanyFilter
  attr_reader :relation, :params

  def initialize(params = {}, relation = Company.all)
    @relation = relation
    @params = params
  end

  def filter
    apply_name_filter
    apply_industry_filter
    apply_min_employee_filter
    apply_min_deal_amount_filter
    apply_select_and_group
    relation.order(created_at: :desc)
  end

  private

  def apply_name_filter
    return unless params[:name].present?

    @relation = relation.by_name(params[:name])
  end

  def apply_industry_filter
    return unless params[:industry].present?

    @relation = relation.by_industry(params[:industry])
  end

  def apply_min_employee_filter
    return unless params['min-employee'].present? && params['min-employee'].to_i.positive?

    @relation = relation.by_min_employee(params['min-employee'])
  end

  def apply_min_deal_amount_filter
    return unless params['min-deal-amount'].present? && params['min-deal-amount'].to_i.positive?

    @relation = relation.by_min_deal_amount(params['min-deal-amount'])
  end

  def apply_select_and_group
    # only finished deals count (exclude 'pending' status)
    sql = %{
      companies.*,
      MIN(CASE
          WHEN deals.status = 'pending'
          THEN 0
          ELSE deals.amount
      END) AS deals_min,
      SUM(CASE
          WHEN deals.status = 'won'
          THEN deals.amount
          WHEN deals.status = 'lost'
          THEN -deals.amount
          ELSE 0
      END) AS deals_sum
    }.squish
    @relation = relation.joins(:deals).select(sql).group('companies.id')
  end
end
