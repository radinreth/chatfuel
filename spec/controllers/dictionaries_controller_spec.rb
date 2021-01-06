require "rails_helper"

RSpec.describe DictionariesController, type: :controller do

  describe "routes" do
    it { should route(:get, "/dictionaries").to(action: :index) }
    it { should route(:patch, "/dictionaries/1").to(action: :update, id: 1) }
  end

  describe "GET #index" do
    context "system admin" do
      setup_system_admin

      it "returns http success" do
        get :index

        expect(response).to have_http_status(:success)
      end
    end

    context "site admin" do
      setup_site_admin

      xit "is not authorize" do
        get :index

        expect(response).to have_http_status(:found)
      end
    end

    context "site_ombudsman" do
      setup_site_ombudsman

      xit "is not authorize" do
        get :index

        expect(response).to have_http_status(:found)
      end
    end
  end

  describe "POST #set_user_visit" do
    setup_system_admin

    describe "user_visit" do
      context "WITHOUT previously set" do
        let(:main_menu) { create(:variable) }

        it "marks as user_visit" do
          post :set_user_visit, params: { variable: { id: main_menu.id } }

          expect(main_menu.reload).to be_user_visit
        end
      end

      context "WITH previously set" do
        let!(:var1) { create(:variable, mark_as: "user_visit") }
        let(:var2) { create(:variable) }

        it "marks as user_visit" do
          post :set_user_visit, params: { variable: { id: var2.id } }

          expect(var2.reload).to be_user_visit
        end
      end
    end

    describe "most_request" do
      context "WITHOUT previously set" do
        let(:main_menu) { create(:variable) }

        it "marks as most_request" do
          post :set_most_request, params: { variable: { id: main_menu.id } }

          expect(main_menu.reload).to be_most_request
        end
      end

      context "WITH previously set" do
        let!(:var1) { create(:variable, mark_as: "most_request") }
        let(:var2) { create(:variable) }

        it "marks as most_request" do
          post :set_most_request, params: { variable: { id: var2.id } }

          expect(var2.reload).to be_most_request
        end
      end
    end

    describe "service_accessed" do
      context "WITHOUT previously set" do
        let(:main_menu) { create(:variable) }

        it "marks as service_accessed" do
          post :set_service_accessed, params: { variable: { id: main_menu.id } }

          expect(main_menu.reload).to be_service_accessed
        end
      end

      context "WITH previously set" do
        let!(:var1) { create(:variable, mark_as: "service_accessed") }
        let(:var2) { create(:variable) }

        it "marks as service_accessed" do
          post :set_service_accessed, params: { variable: { id: var2.id } }

          expect(var2.reload).to be_service_accessed
        end
      end
    end
  end
end
