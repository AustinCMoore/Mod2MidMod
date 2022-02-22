class Studio < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :location
  
  has_many :movies
end
