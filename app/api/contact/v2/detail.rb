module Contact::V2
  class Detail < Grape::API
    format :json
    # include Contact::V2::Error
    # # curl http://localhost:3000/api/v1/contact_data.json
    # rescue_from :all do |e|
    #   error!("rescued from #{e.class.name}")
    # end
    #before { authenticate}
    helpers do
      def authenticate
        #params[:token]== 'jp' ? true : false
        unless params[:token]
          error!('401 Unauthorized', 401)
        end
      end
    end
    
    resource :contact_data do
      desc "List all Contact"
      
      get do
          ContactDatum.all.order(:created_at)
      end
    
      # curl http://localhost:3000/api/v1/contact_create.json -d "name=jayaprakash;address=jjj;"
      # curl -H 'Content-Type:application/json' -H 'Accept:application/json' -X POST http://localhost:3000/api/v1/contact_create -d '{"name":"first name", "address": "last name", "age":25}'

      desc "create a new contact"
      ## This takes care of parameter validation
      params do
        optional :id, desc: 'If not passed, it will be generated'
        requires :email, type: String
        requires :name, type: String
        requires :address, type: String
        requires :age,type: Integer
      end
      ## This takes care of creating contact
      post do
        contact = ContactDatum.create!(declared(params))
        #present contact, with: v2::Entities::Contact
      end
    
      # curl -X DELETE http://localhost:3000/api/v1/delete_contact/1.json
      desc "delete an contact"
      params do
        requires :id, type: String
      end
      delete 'delete/:id' do
        ContactDatum.find(params[:id]).destroy!
      end
 
      # curl -X PUT http://localhost:3000/api/v1/update_contact/2.json -d "address=mumbai"
      # curl -H 'Content-Type:application/json' -H 'Accept:application/json' -X PUT http://localhost:3000/api/v1/update_contact/4 -d '{"name":"last name", "address": "Bangalore", "age":20}'

      desc "update an contact address"
      params do
        requires :id, type: String
        requires :email, type: String
        requires :name, type: String
        requires :address, type: String
        requires :age,type: Integer
      end
      put 'update/:id' do
        ContactDatum.find(params[:id]).update_attributes({
            email:params[:email],
            name:params[:name],
            address:params[:address],
            age:params[:age]
          })
      end


      desc "update an contact address by mail"
      params do
        optional :id, desc: 'If not passed, it will be generated'
        optional :email, type: String
        optional :name, type: String
        optional :address, type: String
        optional :age,type: String
        at_least_one_of :id,:email
      end
      put 'update_by_email' do
        ContactDatum.by_id_or_email!(params[:id], params[:email]).update_attributes!(declared(params, {include_missing: false}))
      end

      
      desc "show contact detail"
    
      params do
        requires :id, type:String
      end
    
      get "show/:id" do
        ContactDatum.find(params[:id])
      end

      desc 'Get a contact based on email'
      params do
        requires :email, type: String , desc: 'email', documentation: {default: 'me@example.com'}
      end

      get 'by_email' do
        ContactDatum.find_by!(email: params[:email])
      end

      desc "delete email"
      params do
        optional :id, desc: 'If not passed, it will be generated'
        optional :email, type: String
        at_least_one_of :id,:email
      end
      delete "delete_by_email" do
        ContactDatum.by_id_or_email!(params[:id], params[:email]).destroy!
      end
    end

  end
end