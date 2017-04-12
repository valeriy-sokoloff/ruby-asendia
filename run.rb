require_relative 'asendia'

cert = '85844.crt.pem'
cert_key = '85844.key.pem'

ct_parcel_data = {
  parcel_data: {
    reference: 'HMUS310113_003',
    recipient: {
      name: 'Hans Muster',
      contact: 'Hans Muster Junior',
      street: 'Musterstrasse',
      no: 1,
      city: 'Bern',
      ZIPCode: 3018,
      region: 'BE',
      country_code: 'CH',
      mobile: '+123456789',
      email: 'hans.muster@gmail.com'
    },
    item_information: {
      weight: 0.9,
      format: 'S'
    },
    basic_service: 'CT',
    additional_service: 72
  },
  document_settings: {
    printer_settings: 'A6',
    start_position: 1,
    document_type: 'PDF'
  }
}

ft_parcel_data = {
  parcel_data: {
    reference: 'HMUS310113_004',
    recipient: {
      name: 'Hans Muster',
      contact: 'Hans Muster Junior',
      street: 'Musterstrasse',
      no: 1,
      city: 'Bern',
      ZIPCode: 3018,
      region: 'BE',
      country_code: 'CH',
      mobile: '+123456789',
      email: 'hans.muster@gmail.com'
    },
    item_information: {
      weight: 0.9,
      format: 'S'
    },
    basic_service: 'FT',
    additional_service: 70
  },
  document_settings: {
    printer_settings: 'A6',
    start_position: 1,
    document_type: 'PDF'
  }
}

# create an Asendia client
client = Asendia.new(cert, cert_key)

# create CT parcel 
response = client.send_parcel_data(ct_parcel_data)

puts response.body[:parcel_label_response][:label_status][:parcel_id]
label_coded = response.body[:parcel_label_response][:label_status][:label_document]
File.open('label_ct.pdf', 'wb'){ |f| f.write(Base64.decode64(label_coded)) }

# create FT parcel
response = client.send_parcel_data(ft_parcel_data)

puts response.body[:parcel_label_response][:label_status][:parcel_id]
label_coded = response.body[:parcel_label_response][:label_status][:label_document]
File.open('label_ft.pdf', 'wb'){ |f| f.write(Base64.decode64(label_coded)) }

