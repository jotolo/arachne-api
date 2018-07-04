class FtpServer < ApplicationRecord
  validates :name, :host, presence: true

  has_many :ftp_files
end
