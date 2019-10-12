class PurchasesController < ApplicationController

  def new
    @item = Item.find(params[:id])
  end

  def create
    if purchaseItem
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :new
    end
  end

  private
  def purchaseItem
    begin
      customer_id = current_user.credit.customer_id
      charge = Payjp::Charge.create(
      amount: params[:item_price],
      currency: 'jpy',
      customer: customer_id,
      )
      Item.find(params[:item_id]).update(status: 4)
    rescue
      false
    end
  end
end
