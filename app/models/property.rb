class Property < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode
  	
  validates :active, presence: true, length: { minimum: 2, maximum: 3 }
  validates :status, presence: true, length: { minimum: 4, maximum: 4 }
  validates :neighborhood, presence: true, length: { minimum: 2, maximum: 20 }
  validates :price, presence: true, length: { minimum: 3, maximum: 10 }
  validates :address, presence: true, length: { minimum: 3, maximum: 100 }
end
