class ItemsController < ApplicationController
  def new
    @item = Item.new
    @images = Image.new
    @category = Category.where(parent_id: 0)
    render "_form"
  end

  def create
    if itemSave
      render json: {'status': "ok"}
    else
      unless request.xhr?
        @errors = @item.errors.full_messages
        @images = Image.new
        @category = Category.where(parent_id: 0)
        render :new
      else request.xhr?
        render plain: ""
      end
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @images = @item.images
    @category = @item.category
    @firstCategory = Category.where(parent_id: @category.parent.parent.parent_id)
    @secondCategory = Category.where(parent_id: @category.parent.parent_id)
    @thirdCategoryList = Category.where(parent_id: @category.parent_id)
    render "_form"
  end

  def update
    if itemSave("update")
      render json: {'status': "ok"}
    else
      unless request.xhr?
        @errors = @updateItem.errors.full_messages
        @item = Item.find(params[:id])
        @images = Item.find(params[:id]).images
        @category = Item.find(params[:id]).category
        @firstCategory = Category.where(parent_id: @category.parent.parent.parent_id)
        @secondCategory = Category.where(parent_id: @category.parent.parent_id)
        @thirdCategoryList = Category.where(parent_id: @category.parent_id)
        render "_form"
      else
        render plain: ""
      end
    end
  end

  private
    def item_params
      params.require(:item).permit(
        :id,
        :name,
        :description,
        :category_id,
        :condition,
        :price,
        :postage,
        :ship_from,
        :days_before_shipment
      )
    end

    def params_int(model_params)
      newparams = {}
      model_params.each do |key, value|
        if key != "images_attributes" && integer_string?(value)
          newparams[key]=value.to_i
        else
            newparams[key]=value
        end
      end
      return newparams
    end

    def integer_string?(str)
      begin
        if str.class != ActionController::Parameters
          Integer(str)
          true
        end
      rescue ArgumentError
        false
      end
    end

    def itemSave(callAction = "create")
      @item = current_user.items.new(params_int(item_params))#paramsを数字にしてimage以外をpermitする
      @item.status = 1

      if callAction == "create"
        @item.save
      elsif params.has_key?(:deleteImageList)
          Item.find(params[:itemId]).images.each do |i|
            params[:deleteImageList].each do |d|
              Image.find(i.id).delete if i.id === d.to_i
            end
          end
      end

      if(params.permit![:item][:image][:image] rescue nil) != nil
        params.permit![:item][:image][:image].each do |x|
          if callAction == "create"
            @item.images.create(image: x) if @item.save
          else
            Item.find(params[:itemId]).images.create(image: x) if @item.valid?
          end
        end
      end

      if callAction == "create"
        @item.save
      elsif callAction == "update"
          if params[:itemId].present?
            #jsからのリクエストにはitemIdが存在する
            @item.id = @item.id = params[:itemId] if callAction == "update"
            @updateItem = Item.find(params[:itemId])
          elsif params[:id].present?
            #htmlからのリクエスト(失敗時)
            @updateItem = Item.find(params[:id]) 
          end
          @updateItem.update(@item.attributes)
      end
  end
end
