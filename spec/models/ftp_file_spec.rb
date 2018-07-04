require 'rails_helper'

RSpec.describe FtpFile, type: :model do
  it 'model validations' do
    should validate_presence_of :name
    should validate_presence_of :path
  end
end
