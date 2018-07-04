class FtpFile < ApplicationRecord
  validates :name, presence: true
  validates :path, presence: true

  belongs_to :ftp_server

  before_save :set_address

  private
  def set_address
    self.address = "#{ftp_server.host}/#{path}/#{name}"
  end
end
