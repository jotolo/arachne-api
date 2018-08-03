class FtpFilesController < ApplicationController
  before_action :set_ftp_file, only: [:show, :update, :destroy]

  # GET /ftp_files
  def index
    @ftp_files = FtpFile.all

    render json: @ftp_files
  end

  # GET /ftp_files/1
  def show
    render json: @ftp_file
  end

  # POST /ftp_files
  def create
    @ftp_file = FtpFile.new(ftp_file_params)

    if @ftp_file.save
      render json: @ftp_file, status: :created, location: @ftp_file
    else
      render json: @ftp_file.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ftp_files/1
  def update
    if @ftp_file.update(ftp_file_params)
      render json: @ftp_file
    else
      render json: @ftp_file.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ftp_files/1
  def destroy
    @ftp_file.destroy
  end


  # GET /ftp_files/search
  def search
    page = params[:page].present? ? params[:page] : 1
    per_page = params[:limit].present? ? params[:limit] : 25
    #order = params[:order].present? ? params[:order] : 'DESC'
    query = params[:query] || "mic"
    #sort = params[:sort].present? ? params[:sort] : 'id'

    @count = FtpFile.search(query, nil).results.total
    files = FtpFile.search(query, @count)
    @ftp_files = files.records.page(page).per_page(per_page)

    render json: { data: @ftp_files, count: @count }
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ftp_file
    @ftp_file = FtpFile.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def ftp_file_params
    params.require(:ftp_file).permit(:name, :path, :address, :ftp_server_id)
  end
end
