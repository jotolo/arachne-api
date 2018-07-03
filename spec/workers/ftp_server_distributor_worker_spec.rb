require 'rails_helper'
RSpec.describe FtpServerDistributorWorker, type: :worker do
  it 'enqueuing FtpServerDistributorWorker' do
    FtpServerDistributorWorker.perform_async
    expect(FtpServerDistributorWorker.jobs.size).to be>0
  end
end
