class BancardTransaction < ApplicationRecord
  belongs_to :order, optional: true
  enum transaction_status: { pending: 0, success: 1, error: 2, confirmed: 3, rollback: 4, canceled: 5 }

  def formatted_amount
    format('%<total>0.2f', total: total_amount)
  end

  def set_shop_process_id
    id = self.id

    new_shop_process_id = format('%<id>s%<random>s',
                                 { id: id, random: SecureRandom.random_number(1000..9999) })

    until BancardTransaction.where(shop_process_id: new_shop_process_id).count.zero?
      new_shop_process_id = format('%<id>s%<random>s',
                                   { id: id, random: SecureRandom.random_number(1000..9999) })
    end
    self.shop_process_id = new_shop_process_id
  end

  def self.valid_token?(operation)
    received_token = operation[:token].to_s
    private_key = ENV['BANCARD_PRIVATE_KEY']

    check_token = Digest::MD5.hexdigest(
      private_key +
      operation[:shop_process_id].to_s +
      'confirm' +
      operation[:amount].to_s +
      operation[:currency].to_s
    )

    received_token.include?(check_token)
  end

  def process_response(operation)
    self.transaction_status = case operation[:response_code]
                              when '00'
                                :success
                              else
                                :error
                              end
    self.response = operation[:response]
    self.response_details = operation[:response_details]
    self.auth_number = operation[:authorization_number].to_i
    self.ticket_number = operation[:ticket_number].to_i
    self.response_code = operation[:response_code]
    self.response_description = operation[:response_description]
    self.extended_description = operation[:extended_response_description]
    self.customer_ip = operation[:security_information][:customer_ip]
    self.card_country = operation[:security_information][:card_country]
    self.risk_index = operation[:security_information][:risk_index]
    save!
  end
end
