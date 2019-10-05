class ItemsController < ApplicationController
  def new
    @item = Item.new
    @image = Image.new
    @category = Category.where(parent_id: 0)
  end

  def create
    if itemSave
      redirect_to root_path
    else
      @errors = @item.errors.full_messages
      @image = Image.new
      @category = Category.where(parent_id: 0)
      render :new
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
        if key != "images_attributes"
          if integer_string?(value)
            newparams[key]=value.to_i
          else
            newparams[key]=value
          end
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

