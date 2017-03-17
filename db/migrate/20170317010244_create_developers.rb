class CreateDevelopers < ActiveRecord::Migration[5.0]
  def change
    create_table :developers do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :title
      t.text :description
      t.references :user, foreign_key: true
      t.string :language1
      t.string :language2
      t.string :language3
      t.string :language4
      t.string :nationality
      t.date :birthday

      t.timestamps
    end
  end
end
