class ChangePasswordFromnUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.rename :pasword, :password
    end
  end
end
