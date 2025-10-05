class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_one :shopping_cart, dependent: :destroy
  has_many :orders, dependent: :restrict_with_error
  after_create :send_welcome_email

  DOCUMENT_TYPES = [
    { name: 'Cedula de Identidad', value: 'CI' },
    { name: 'RUC', value: 'RUC' }
  ].freeze

  DEPARTMENTS = [
    'CENTRAL',
    'ASUNCION',
    'CONCEPCION',
    'CORDILLERA',
    'GUAIRA',
    'ALTO PARANA',
    'PILAR',
    'CORONEL OVIEDO',
    'BOQUERON'

  ].freeze

  CITIES = [
    'Areguá',
    'Asunción',
    'Capiatá',
    'Fernando de la Mora',
    'Guarambaré',
    'Itá',
    'Itauguá',
    'J. Augusto Saldívar',
    'Lambaré',
    'Limpio',
    'Luque',
    'Mariano Roque Alonso',
    'Ñemby',
    'Paraguari',
    'San Antonio',
    'San Lorenzo',
    'Villa Elisa',
    'Villeta',
    'Yaguaron',
    'Ypacarai',
    'Ypané'
  ].freeze

  def self.create_from_provider_data(provider_data, qr_link)
    Rails.logger.debug("Promo desde model: #{qr_link}")
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email

      case provider_data.provider
      when 'facebook'
        first_name = provider_data.info.name.split(' ', 2)[0]
        last_name = provider_data.info.name.split(' ', 2)[1] || ''
      else
        first_name = provider_data.info.first_name
        last_name = provider_data.info.last_name
      end

      if qr_link != ""
        user.new_user = true
        user.new_sm = true
        user.from_sm = true
        user.qr_link = qr_link

        #Generate cupon
        #name = "#{first_name} #{last_name}"
        #url = ENV['ERP_SERVICE_CUPON_URL']
        #token = ENV['ERP_SERVICE_TOKEN']
        #qr_link = user.qr_link

        ##Aqui me quedo hasta saber que hacer.
        #id_number = user.id_number

        #Rails.logger.debug("nombre: #{name} - QR_LINK #{qr_link} - idnumber #{id_number}")
        #data_params = "token=#{token}&docnro=#{id_number}&razonsocial=#{name}&qr=#{qr_link}"
        #Rails.logger.debug("Data params: #{data_params}")

        #service_response = Faraday.post(url, data_params)
        #response_data = JSON.parse(service_response.body)

        #Rails.logger.debug(response_data)

      else
        user.new_user = false
        user.new_sm = false
        user.from_sm = false
        user.qr_link = ''
      end

      user.firstname = first_name
      user.lastname = last_name
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def fullname
    first = firstname.nil? ? '' : firstname
    last = lastname.nil? ? '' : lastname

    format('%<first>s %<last>s', { first: first, last: last })
  end

  private

  def send_welcome_email
    WelcomeMailer.welcome_email(self).deliver
  end

  def update_resource(resource, params)
    puts "params ===> #{params}"
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
      params.delete(:current_password)
      resource.update_without_password(params)
    else
      super
    end
  end

end
