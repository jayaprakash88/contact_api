# module Contact::V2
#   module Error
#     extend ActiveSupport::Concern

#     included do
#       rescue_from :all do |e|

#           # When required params are missing or validation fails
#           if e.class.name == 'Grape::Exceptions::ValidationErrors'
#             error!(e.message, status: 406)

#           # Bad token
#           elsif e.class.name == 'RuntimeError' && e.message == 'Invalid base64 string'  
#             error!('401 Unauthorized', status: 401)

#           # AccessDenied - Authorization failure
#           elsif e.class.name == 'CanCan::AccessDenied'
#             error!('You don\'t have permissions.', status: 403)

#           # Record not found
#           elsif e.class.name == ActiveRecord::RecordNotFound
#             error!('You don\'t have permissions.', status: 404)

#           # When all hell broke loose
#           else
#             Rails.logger.error "\n#{e.class.name} (#{e.message}):"
#             e.backtrace.each { |line| Rails.logger.error line }
#             Rack::Response.new({
#               error: '400 Bad Request',
#               errors: e.errors
#             }.to_json, 400)
#           end
#         end
#       end
#     end
# end