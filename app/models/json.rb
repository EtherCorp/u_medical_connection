# For json data from medical_center
class Json
  include Mongoid::Document
  field :token, type: String
  field :medical_center, type: String
  field :title, type: String
  field :body, type: String
end
