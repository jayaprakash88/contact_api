module Contact
  class Data < Grape::API
    format :json
# curl http://localhost:3000/api/v1/contact_data.json
    resource :contact_data do
      desc "List all Contact"

      get do
        ContactDatum.all.order(:created_at)
      end
    end
  
# curl http://localhost:3000/api/v1/contact_create.json -d "name=jayaprakash;address=jjj;"
# curl -H 'Content-Type:application/json' -H 'Accept:application/json' -X POST http://localhost:3000/api/v1/contact_create -d '{"name":"first name", "address": "last name", "age":25}'


    resource :contact_create do 
      desc "create a new contact"
      ## This takes care of parameter validation
      params do
        requires :email, type: String
        requires :name, type: String
        requires :address, type: String
        requires :age,type: Integer
      end
      ## This takes care of creating employee
      post do
        contact=ContactDatum.create!(declared(params))
      end
    end
    
# curl -X DELETE http://localhost:3000/api/v1/delete_contact/1.json
    resource :delete_contact do 
      desc "delete an contact"
      params do
        requires :id, type: String
      end
      delete ':id' do
        ContactDatum.find(params[:id]).destroy!
      end
    end

## delete email 
     resource :delete_email do 
      desc "delete an contact"
      params do
        requires :email, type: String
      end
      delete ':email' do
        ContactDatum.where("email =?",params[:email]).last.destroy!
      end
    end
 
# curl -X PUT http://localhost:3000/api/v1/update_contact/2.json -d "address=mumbai"
# curl -H 'Content-Type:application/json' -H 'Accept:application/json' -X PUT http://localhost:3000/api/v1/update_contact/4 -d '{"name":"last name", "address": "Bangalore", "age":20}'

    resource :update_contact do 
      desc "update an contact address"
      params do
        requires :id, type: String
        requires :name, type: String
        requires :address, type: String
        requires :age,type: Integer
      end
      put ':id' do
        ContactDatum.find(params[:id]).update_attributes({
            name:params[:name],
            address:params[:address],
            age:params[:age]
          })
      end
    end

  end
end