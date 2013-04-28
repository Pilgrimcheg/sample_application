class HotelsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def create
    @hotel = current_user.hotels.build(params[:hotel])
    if @hotel.save
      flash[:success]="Hotel created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @hotel.destroy
    redirect_to root_url
  end

  private

  def correct_user
    @hotel = current_user.hotels.find_by_id(params[:id])
    redirect_to root_url if @hotel.nil?
  end

end