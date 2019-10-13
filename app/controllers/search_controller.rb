class SearchController < ApplicationController
  
  def index
    @q = Item.ransack(params[:q])
  end

  def create
    @q = Item.ransack(params[:q])
    @item = @q.result
    @conditions = Item.conditions.keys
    @category = Category.where(parent_id: 0)
    @postages = Item.postages.keys
    @status = Item.statuses.keys
    render :index
  end
end
