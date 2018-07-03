class FtpServerDistributorWorker
  include Sidekiq::Worker

  def perform(*args)
    FtpServer.find_each do |ftp|
      FtpServerScannerDistributorWorker.perform_async(ftp.id, '/')
    end
  end
end
