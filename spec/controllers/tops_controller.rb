require 'rails_helper'

describe TopController do
  describe 'GET #index' do
    it "assigns the requested item to @item" do
      items = create_list(:item,3)
      get :index
      expect(assigns(:items)).to match(items)
    end

    it "render the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end
end
