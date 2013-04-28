class StaticPagesController < ApplicationController
  def home
    if signed_in?
    @hotel = current_user.hotels.build
    @feed_items = current_user.feed.paginate(page: params[:page], per_page: 4)
  end
  end

  def help
  end

  def about
  end

  def contact
  end

end
