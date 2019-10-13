class SearchController < ApplicationController
  
  def create
    @q = Item.ransack(params[:q])
    @item = @q.result
    render :index
  end
end