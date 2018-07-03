require 'rails_helper'
RSpec.describe FtpServerScannerDistributorWorker, type: :worker do
  it 'enqueuing FtpServerScannerDistributorWorker' do
    ftp_server = FactoryBot.create(:ftp_server)
    FtpServerScannerDistributorWorker.perform_async(ftp_server.id)
    expect(FtpServerScannerDistributorWorker.jobs.size).to be>0
  end
end
