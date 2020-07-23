require "rails_helper"

RSpec.describe TicketsController, type: :controller do
  setup_system_admin

  it "GET :index" do
    get :index

    expect(response).to render_template("index")
  end
end
