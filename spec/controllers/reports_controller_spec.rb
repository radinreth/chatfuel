require "rails_helper"

RSpec.describe ReportsController, type: :controller do
  setup_system_admin

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:found)
    end
  end

  describe "GET #index with params" do
    it "return instance of StepCollectionDecorator or TicketCollectionDecorator" do
      get :index, params: { dates: "28/02/2020 - 28/02/2020" }

      expect(assigns(:goals)).to all(be_a(StepCollectionDecorator).or be_a(TicketCollectionDecorator))
    end
  end

end
