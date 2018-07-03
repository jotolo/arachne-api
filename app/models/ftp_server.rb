class FtpServer < ApplicationRecord
  validates :name, :host, presence: true
end
