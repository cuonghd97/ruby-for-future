class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :pasword
      t.integer :role

      t.timestamps
    end
  end
end
