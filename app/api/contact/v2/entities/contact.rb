module Entities
  class Contact < Grape::Entity
    expose :id
    expose :email
    expose :name
    expose :address
    expose :age
   end
end
