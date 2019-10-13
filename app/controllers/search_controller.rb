class SearchController < ApplicationController
  
  def index
    @q = Item.ransack(params[:q])
  end
  
  def create
    @q = Item.ransack(params[:q])
    @item = @q.result
    render :index
  end
end