class AddColumnEmailToContact < ActiveRecord::Migration[5.1]
  def change
    add_column :contact_data,:email,:string
  end
end
