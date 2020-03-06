module ControllerMacros
  def login_system_admin
    before(:each) do
      system_admin = create(:user, role: :system_admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(system_admin)
      allow(controller).to receive(:current_user).and_return(system_admin)
    end
  end

  def login_site_admin
    before(:each) do
      site_admin = create(:user, role: :site_admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(site_admin)
      allow(controller).to receive(:current_user).and_return(site_admin)
    end
  end

  def login_ombudsman
    before(:each) do
      ombudsman = create(:user, role: :ombudsman)
      allow(request.env['warden']).to receive(:authenticate!).and_return(ombudsman)
      allow(controller).to receive(:current_user).and_return(ombudsman)
    end
  end
end
