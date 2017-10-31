module Contact
  module V2
    module Entities
      class JustId < Grape::Entity
        expose :id, documentation: {desc: 'UUID', default: '1fe6538d-0425-43eb-a2ba-bb2b69c179ef'}
      end
    end
  end
end
