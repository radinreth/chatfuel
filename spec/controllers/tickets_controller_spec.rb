require "rails_helper"

RSpec.describe TicketsController, type: :controller do
  setup_system_admin

  it "GET :index" do
    get :index

    expect(response).to render_template("index")
  end

  it "GET :new" do
    get :new

    expect(response).to render_template("new")
  end

  it "GET :edit" do
    get :edit, params: { id: create(:ticket).id }

    expect(response).to render_template("edit")
  end

  it "POST :create" do
    expect do
      post :create, params: { ticket: { code: "123", site_id: create(:site).id } }
    end.to change { Ticket.count }.by(1)
  end

  context "updates" do
    let(:new_template) { create(:ticket, code: "12345") }

    it "PUT :update" do
      put :update, params: { id: new_template.id, ticket: { code: "123" } }

      updated = assigns(:ticket)

      expect(response).to have_http_status(:moved_permanently)
      expect(updated.code).to eq "123"
    end
  end

  context "destroy" do
    before do
      @ticket = create(:ticket, code: "123")
    end

    it "DELETE :destroy" do
      expect do
        delete :destroy, params: { id: @ticket.id }
      end.to change { Ticket.count }.by(-1)
    end
  end
end
