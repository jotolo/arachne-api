require 'net/ftp'
require 'net/ftp/list'
class FtpServerScannerDistributorWorker
  include Sidekiq::Worker

  def perform(ftp_server_id, path = nil)
    ftp_server = FtpServer.find(ftp_server_id)

    ftp = Net::FTP.open(ftp_server.host, ftp_server.user, ftp_server.password)
    ftp.list(path) do |e|
      entry = Net::FTP::List.parse(e)

      # Ignore everything that's not a file (so symlinks, directories and devices etc.)
      if entry.file?
        FtpFile.create(name: entry.basename, path: path, ftp_server_id: ftp_server_id)
        #puts "#{path + '/' + entry.basename}, #{entry.filesize}, #{entry.mtime}"
      elsif entry.dir?
        new_path = path ? File.join(path,entry.basename) : File.join(File::SEPARATOR,entry.basename)
        FtpServerScannerDistributorWorker.perform_async(ftp_server_id, new_path)
      else
        # Unknown case
      end
    end
  end
end
