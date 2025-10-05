class AmountDiscount < ApplicationRecord
  def self.discount_rate(gross_amount, date = Time.now.strftime('%Y-%m-%d'))
    discount_record = where(['min_amount <= ? AND max_amount >= ?', gross_amount, gross_amount])
                      .where(['begin_date <= ? AND end_date >= ?', date, date])
                      .first
    if discount_record
      discount_record.discount_rate
    else
      0
    end
  end
end
