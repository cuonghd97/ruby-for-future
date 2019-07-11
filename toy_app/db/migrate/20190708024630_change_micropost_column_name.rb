class ChangeMicropostColumnName < ActiveRecord::Migration[6.0]
  def change
    change_table :microposts do |t|
      t.rename :contect, :content
    end
  end
end
