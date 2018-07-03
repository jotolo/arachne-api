require 'rails_helper'

RSpec.describe FtpServer, type: :model do
  it 'model validations' do
    should validate_presence_of :name
    should validate_presence_of :host
  end
end
