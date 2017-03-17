class Developer < ApplicationRecord
  belongs_to :user
  has_attachments :photo, maximum: 5
  validates_uniqueness_of :username, :on => :create, :message => "That username is already in use"
  validates_presence_of :username, :first_name, :last_name, :title, :description, :language1, :on => :create, :message => "This field can't be blank"
end
