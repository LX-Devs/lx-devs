class Developer < ApplicationRecord
  belongs_to :user
  has_many :projects
  has_attachments :photo, maximum: 5
  validates_uniqueness_of :username, :on => :create, :message => "That username is already in use"
  validates_presence_of :username, :first_name, :last_name, :title, :description, :language1, :on => :create, :message => "This field can't be blank"
  validates_inclusion_of :language1, :language2, :language3, :language4, :in => %w( Ruby Rails HTML CSS JS JQuery SQL Node React Angular PHP Python ), :allow_nil => true, :on => :create, :message => "That language %s is not included in the list"
  accepts_nested_attributes_for :projects, :allow_destroy => true
end
