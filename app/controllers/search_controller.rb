class SearchController < ApplicationController
  
  def index
    @q = Item.ransack(params[:q])
  end

  def create
    paramsSearchWords = params[:q].permit!.to_hash

    if paramsSearchWords["name_cont_all"].present?
      searchItemName = paramsSearchWords["name_cont_all"].scan(/[a-z[0-9]]/)
      paramsSearchWords.delete(:name_cont_all)
      paramsSearchWords.store("name_cont_all", searchItemName)
    end

    if paramsSearchWords["prise"].present?
      priceRange = paramsSearchWords["price"].scan(/[0-9]{3,5}/)
      paramsSearchWords.store("price_greq", priceRange[0])
      paramsSearchWords.store("price_lt", priceRange[1])
    end
    
    @q = Item.ransack(paramsSearchWords)
    @item = @q.result
    @conditions = Item.conditions.keys
    @category = Category.where(parent_id: 0)
    @postages = Item.postages.keys
    @status = Item.statuses.keys
    render :index
  end
end
