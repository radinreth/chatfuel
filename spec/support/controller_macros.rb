module ControllerMacros
  def login_system_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user] if @request.present?
      system_admin = create(:user, :system_admin)
      system_admin.confirm
      sign_in system_admin
    end
  end

  def setup_system_admin
    before(:each) do
      system_admin = create(:user, :system_admin)
      allow(request.env["warden"]).to receive(:authenticate!).and_return(system_admin)
      cookies[:guisso] = system_admin.email
      allow(controller).to receive(:current_user).and_return(system_admin)
    end
  end

  def setup_site_admin
    before(:each) do
      site_admin = create(:user, :site_admin)
      allow(request.env["warden"]).to receive(:authenticate!).and_return(site_admin)
      cookies[:guisso] = site_admin.email
      allow(controller).to receive(:current_user).and_return(site_admin)
    end
  end

  def setup_site_ombudsman
    before(:each) do
      site_ombudsman = create(:user, :site_ombudsman)
      allow(request.env["warden"]).to receive(:authenticate!).and_return(site_ombudsman)
      cookies[:guisso] = site_ombudsman.email
      allow(controller).to receive(:current_user).and_return(site_ombudsman)
    end
  end
end
