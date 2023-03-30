class InstructorSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :students #this includes the students array in the get request for all instructors.
end
 