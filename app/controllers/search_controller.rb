class SearchController < ApplicationController
  
  def index
    @q = Item.ransack(params[:q])
  end

  def create
    if params[:q].nil? #ヘッダーからの簡易検索
      paramsSearchWords = simpleSearch(params.require(:item)[:name]) 
    else
      paramsSearchWords = detailSearch(params)
    end
    @q = Item.ransack(paramsSearchWords)
    @item = @q.result
    @conditions = Item.conditions.keys
    @category = Category.where(parent_id: 0)
    @postages = Item.postages.keys
    @status = Item.statuses.keys
    render :index
  end

  private

  def simpleSearch(searchItemName)
    paramsSearchWords = {}
    paramsSearchWords.store("name_cont_all", searchItemName)
    return paramsSearchWords
  end
  
  def detailSearch(params)
    paramsSearchWords = params[:q].permit!.to_hash

    #nameのand検索のためのparams整形
    if paramsSearchWords["name_cont_all"].present?
      searchItemName = paramsSearchWords["name_cont_all"].scan(/[a-z[0-9]]/)
      paramsSearchWords.delete(:name_cont_all)
      paramsSearchWords.store("name_cont_all", searchItemName)
    end

    #priceのためのparams整形
    if paramsSearchWords["prise"].present?
      priceRange = paramsSearchWords["price"].scan(/[0-9]{3,5}/)
      paramsSearchWords.store("price_greq", priceRange[0])
      paramsSearchWords.store("price_lt", priceRange[1])
    end

    #categoryのためのparams整形
    if paramsSearchWords["category_id_cont_all"][0].present?
      category_id = nil
      paramsArrayCount = 0
      paramsSearchWords["category_id_cont_all"].each do |c| #paramsから来た配列の空文字削除
        if c.empty?
          paramsSearchWords["category_id_cont_all"].delete_at(paramsArrayCount)
          break
        end
        paramsArrayCount += 1
        category_id = c
      end
      grandChildCategoryId = []
      if paramsSearchWords["category_id_cont_all"].length == 1
        Category.find(category_id).categories.each do |child|
          child.categories.each do |grandChild|
            grandChildCategoryId.push(grandChild.id)
          end
        end
      elsif paramsSearchWords["category_id_cont_all"].length == 2
        Category.find(category_id).categories.each do |child|
            grandChildCategoryId.push(child.id)
        end
      elsif paramsSearchWords["category_id_cont_all"].length == 3
        grandChildCategoryId = paramsSearchWords["category_id_cont_all"][2]
      end

      paramsSearchWords.delete("category_id_cont_all")
      if grandChildCategoryId.nil?
        paramsSearchWords.store("category_id_not_eq_all", grandChildCategoryId)
      else
        paramsSearchWords.store("category_id_eq_any", grandChildCategoryId)
      end
    end
    return paramsSearchWords
  end
end
