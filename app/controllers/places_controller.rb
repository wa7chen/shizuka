class PlacesController < ApplicationController
  before_action :set_place, only: [:show]

  def index
    @places = Place.in_rectangle([110, 50], [130, 30]).collect do |p|
      {
        id: p["_id"],
        location: p["_source"]["location"],
        comments: p["_source"]["comments"]
      }
    end
    # respond_to do |format|
    #   format.html { render 'index' }
    #   format.json {}
    # end
  end

  def show
  end

  def new
    @place = Place.new
    @place.latitude = params[:latitude]
    @place.longitude = params[:longitude]
    @comment = Comment.new
  end

  def create
    @place = Place.new(place_params)
    @place.comments.build(comment_params)
    if @place.save
      redirect_to @place, notice: 'Place was successfully created.'
    else
      render action: 'new'
    end
  end

  private
  def set_place
    @place = Place.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:latitude, :longitude)
  end

  def comment_params
    params.require(:place).permit(comment: [:mood, :things])[:comment]
  end
end
