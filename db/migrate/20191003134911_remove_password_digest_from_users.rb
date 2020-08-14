class RemovePasswordDigestFromUsers < ActiveRecord::Migration[6.0]
  def change
  	remove_column :users,:password_digest, :confirm_password
  end
end
