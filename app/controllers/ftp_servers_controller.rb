class FtpServersController < ApplicationController
  before_action :set_ftp_server, only: [:show, :update, :destroy]

  # GET /ftp_servers
  def index
    @ftp_servers = FtpServer.all

    render json: @ftp_servers
  end

  # GET /ftp_servers/1
  def show
    render json: @ftp_server
  end

  # POST /ftp_servers
  def create
    @ftp_server = FtpServer.new(ftp_server_params)

    if @ftp_server.save
      render json: @ftp_server, status: :created, location: @ftp_server
    else
      render json: @ftp_server.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ftp_servers/1
  def update
    if @ftp_server.update(ftp_server_params)
      render json: @ftp_server
    else
      render json: @ftp_server.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ftp_servers/1
  def destroy
    @ftp_server.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ftp_server
      @ftp_server = FtpServer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ftp_server_params
      params.require(:ftp_server).permit(:name, :host, :port, :user, :password)
    end
end
