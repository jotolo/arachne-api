FactoryBot.define do
  factory :ftp_file do
    name {Faker::File.file_name.split('/').last}
    path {Faker::File.file_name.split('/').first}
    ftp_server_id {

      if FtpServer.count == 0
        FactoryBot.create(:ftp_server).id
      else
        if rand > 0.3
          FtpServer.all.sample.id
        else
          FactoryBot.create(:ftp_server).id
        end
      end
    }
  end
end
