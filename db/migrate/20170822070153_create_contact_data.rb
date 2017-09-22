class CreateContactData < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto'
    create_table :contact_data, id: :uuid do |t|
      t.string :name
      t.string :address
      t.integer :age

      t.timestamps
    end
  end
end
