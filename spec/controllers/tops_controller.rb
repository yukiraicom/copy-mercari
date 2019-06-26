require 'rails_helper'

describe TopController do
  describe 'GET #index' do
    get :index
    expect(response).to render_template :index
  end
end
