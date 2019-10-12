class PurchasesController < ApplicationController

  def new
    @item = Item.find(params[:id])
  end

  def create
    customer_id = current_user.credit.customer_id
    charge = Payjp::Charge.create(
    amount: params[:item_price],
    currency: 'jpy',
    customer: customer_id,
    )
    redirect_to root_path
  end
end
