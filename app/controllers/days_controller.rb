class DaysController < ApplicationController
  before_action :set_day, only: [:show, :update, :destroy]
  before_action :set_other, only: [:page, :create]
  # GET /days
  def index
    @days = Day.all

    render json: JsonRes.success('',@days)
  end

  def page
    @days = @trip.days.order("created_at").page(params[:page])
    render json: JsonRes.success('',@days)
  end

  # GET /days/1
  def show
    render json: JsonRes.success('',@day)
  end

  # POST /days
  def create
    @day = @trip.days.new(day_params)

    if @day.save
      render json: JsonRes.success('',@day), status: :created, location: @day
    else
      render json: JsonRes.errors('',@day.errors), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /days/1
  def update
    if @day.update(day_params)
      render json: JsonRes.success('',@day)
    else
      render json: JsonRes.errors('',@day.errors), status: :unprocessable_entity
    end
  end

  # DELETE /days/1
  def destroy
    @day.destroy
    render json: JsonRes.destroy('day',params[:did]), status: :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_other
      ap @user
      @trip = @user.trips.find(params[:tid])
    end

    def set_day
      @day = Day.find(params[:did])
    end

    # Only allow a trusted parameter "white list" through.
    def day_params
      params.require(:day).permit(:seq, :alias)
    end
end
