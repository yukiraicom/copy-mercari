class ItemsController < ApplicationController
  def new
    @item = Item.new
    @images = Image.new
    @category = Category.where(parent_id: 0)
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

    def itemSave
      @item = Item.new(params_int(item_params))#paramsを数字にしてimage以外をpermitする
      @item.status = 1
      begin
        params.permit![:item][:image][:image].each do |x|
          @item.images.create(image: x) if @item.save
        end
      rescue
        false
      end
      @item.save
    end
end

