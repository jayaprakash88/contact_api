module Contact
	module V2
		module Entities
			class Contact < Grape::Entity
				expose :id, documentation: {desc: 'UUID', default: '1fe6538d-0425-43eb-a2ba-bb2b69c179ef'}
				expose :email, documentation: {default: 'me@example.com'}
				expose :name, documentation: {desc: 'Person name either first or last name',default: 'John'}
				expose :address, documentation: {desc: 'Street name, City and State',default: 'Bangalore'}
				expose :age, documentation: {desc: 'age',default: '20'}
			end
		end
	end
end
