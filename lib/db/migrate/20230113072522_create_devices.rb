class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.string :refresh_token
      t.integer :platform, default: 0
      t.references :resourceable, polymorphic: true

      t.timestamps
    end

    add_index :devices, :refresh_token, unique: true
  end
end
