class AddCoordinatesToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :location, :string
    add_column :projects, :latitude, :float
    add_column :projects, :longitude, :float
  end
end
