class CreateFtpFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :ftp_files do |t|
      t.string :name
      t.text :path
      t.text :address, null: false
      t.integer :ftp_server_id

      t.timestamps
    end
  end
end
