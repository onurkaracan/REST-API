class HousesController < ApplicationController
  before_action :set_house, only: %i[ show update destroy ]

  # GET /houses
  def index
    @houses = House.all

    render json: @houses
  end

  def filtered_houses
    #params page_number, page_size
    page_size = params["page_size"] || 10
    page_number = params["page_number"] || 1
    @houses = House.all
    @houses = @houses.where("max_guests <= ?", params["max_guests"]) if params["max_guests"]
    @houses = @houses.where("available_from < ?", params["available_from"]) if params["available_from"]
    @houses = @houses.where("available_to > ?", params["available_to"]) if params["available_to"]
    @houses.limit(page_size).offset(page_number * page_size)
    render json: @houses.select(:name, :description, :amenities)
  end

  def book_house
    user = User.find_by(username:params["username"], password:params["password"])
    render json: false, status: :unauthorized and return unless user
    @houses = House.all
    @houses = @houses.where("name = ?", params["name"]) if params["name"]
    @houses = @houses.where("available_from < ?", params["available_from"]) if params["available_from"]
    @houses = @houses.where("available_to > ?", params["available_to"]) if params["available_to"]
    if @houses.empty?
      render json:@houses, status: :no_content
    else
      @bookings = Booking.all
      @bookings = @bookings.where("name = ?", params["name"]) if params["name"]
      @bookings = @bookings.where('"from" <= ?', params["available_from"]) if params["available_from"]
      @bookings = @bookings.where('"to" >= ?', params["available_to"]) if params["available_to"]
      if @bookings.empty?
        @booking = Booking.new({
                                 :house_id => @houses.first.id,
                                 :name => @houses.first.name,
                                 :from => params["available_from"],
                                 :to => params["available_to"]
                               })
        if @booking.save
          render json: @booking, status: :created, location: @booking
        else
          render json: @booking.errors, status: :unprocessable_entity
        end
      else
        render json: false, status: :unprocessable_entity
      end
    end
  end
  # GET /houses/1
  def show
    render json: @house
  end

  # POST /houses
  def create
    @house = House.new(house_params)

    if @house.save
      render json: @house, status: :created, location: @house
    else
      render json: @house.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /houses/1
  def update
    if @house.update(house_params)
      render json: @house
    else
      render json: @house.errors, status: :unprocessable_entity
    end
  end

  # DELETE /houses/1
  def destroy
    @house.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def house_params
      params.permit(:name, :description, :max_guests, :amenities, :available_from, :available_to)
    end
end
