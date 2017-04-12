require 'savon'

class Asendia
  attr_accessor :client

  def initialize(cert, cert_key)
    @client = Savon.client(
      wsdl: "B2CParcelService.wsdl",
      ssl_cert_file: cert,
      ssl_cert_key_file: cert_key,
      convert_request_keys_to: :camelcase,
    )
  end

  def connection_test
    @client.call(:connection_test)
  end

  def send_parcel_data(message)
    @client.call(:send_parcel_data, message: message)
  end
end
