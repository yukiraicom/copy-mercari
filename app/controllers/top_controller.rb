class TopController < ApplicationController
  def index
    @items = Item.all
    @q = Item.ransack(params[:q])
  end
end
