require 'grape-swagger'

class API < Grape::API
  rescue_from ActiveRecord::RecordNotFound do |e|
    error!('Record not found', 404)
  end

  rescue_from ActiveRecord::RecordNotUnique do |e|
    error!('Record not unique', 422)
  end

  rescue_from ActiveRecord::ActiveRecordError do |e|
    error!(e.message, 422)
  end
  prefix 'api'
  version 'v1', using: :path
  mount Contact::Data
 # include Contact::V2::Error
  prefix 'api'
  version 'v2', using: :path
  mount Contact::V2::Detail

  add_swagger_documentation mount_path: '/swagger_doc',
                           schemes: ['http'],
                           host: 'localhost:3000',
                           doc_version: '0.0.1 Draft',
                           info: {
                               title: 'Contact API',
                               description: 'API for contact details'
                           }

  
end