class RemoveAddressFromUser < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :Address, :string
  end
end
