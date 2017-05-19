class Project < ApplicationRecord
  belongs_to :developer
  validates_presence_of :name, :description, :url, :message => "This field can't be blank"
  validates :url, :url => true


  geocoded_by :location
  after_validation :geocode, if: :location_changed?

end
