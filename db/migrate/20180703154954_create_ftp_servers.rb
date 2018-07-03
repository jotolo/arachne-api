class CreateFtpServers < ActiveRecord::Migration[5.2]
  def change
    create_table :ftp_servers do |t|
      t.string :name
      t.string :host
      t.string :user, default: 'anonymous'
      t.string :password

      t.timestamps
    end
  end
end
