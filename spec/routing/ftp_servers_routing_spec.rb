require 'rails_helper'

RSpec.describe FtpServersController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/ftp_servers').to route_to('ftp_servers#index')
    end


    it 'routes to #show' do
      expect(:get => '/ftp_servers/1').to route_to('ftp_servers#show', :id => '1')
    end


    it 'routes to #create' do
      expect(:post => '/ftp_servers').to route_to('ftp_servers#create')
    end

    it 'routes to #update via PUT' do
      expect(:put => '/ftp_servers/1').to route_to('ftp_servers#update', :id => '1')
    end

    it 'routes to #update via PATCH' do
      expect(:patch => '/ftp_servers/1').to route_to('ftp_servers#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/ftp_servers/1').to route_to('ftp_servers#destroy', :id => '1')
    end

  end
end
