require "rails_helper"

RSpec.describe TemplatesController, type: :controller do
  setup_system_admin

  let(:template) { create(:template) }

  context "html" do
    it "GET :index" do
      get :index

      expect(response).to render_template("index")
    end
  end

  it "GET :new" do
    get :new

    expect(response).to render_template("new")
  end

  it "POST :create" do
    expect do
      post :create, params: { template: { content: "new template", type: "MessengerTemplate" } }, format: :js
    end.to change { Template.count }.by(1)
  end

  context "updates" do
    let(:new_template) { create(:template, content: "new template") }

    it "PUT :update" do
      put :update, params: { id: new_template.id, template: { content: "template" } }, format: :js

      updated = assigns(:template)

      expect(updated.content).to eq "template"
    end
  end

  context "destroy" do
    before do
      @template = create(:template, content: "template")
    end

    it "DELETE :destroy" do
      expect do
        delete :destroy, params: { id: @template.id }
      end.to change { Template.count }.by(-1)
    end
  end
end
