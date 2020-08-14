class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :p_id
      t.string :name
      t.date :dob
      t.string :string
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
