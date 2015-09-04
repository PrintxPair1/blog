require 'zxing'

class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.pluck(:name, :id)

    render json: @images
  end

  # GET /images/1
  # GET /images/1.json
  def show

    render :json => @image.to_json(:only => [:id, :name])
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new
    @image.name = image_params["name"]
    @image.image_file = image_params["data"]
    if @image.save
      File.open(@image.name, 'wb') { |file| file.write(@image.data) }
      zx_return = ZXing.decode File.new(@image.name)
      render json: { :image => @image.name, :zxing => zx_return } , status: :created, location: @image
      @image.destroy
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    @image = Image.find(params[:id])

    if @image.update(image_params)
      head :no_content
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy

    head :no_content
  end

  private

    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:data, :name)
    end
end
