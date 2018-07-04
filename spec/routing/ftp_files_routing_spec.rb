require 'rails_helper'

RSpec.describe FtpFilesController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/ftp_files').to route_to('ftp_files#index')
    end


    it 'routes to #show' do
      expect(:get => '/ftp_files/1').to route_to('ftp_files#show', :id => '1')
    end


    it 'routes to #create' do
      expect(:post => '/ftp_files').to route_to('ftp_files#create')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/ftp_files/1').to route_to('ftp_files#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/ftp_files/1').to route_to('ftp_files#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/ftp_files/1').to route_to('ftp_files#destroy', :id => '1')
    end

  end
end
