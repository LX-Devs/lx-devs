class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.references :developer, foreign_key: true
      t.string :name
      t.text :description
      t.date :date_completed
      t.string :url
      t.string :type

      t.timestamps
    end
  end
end
