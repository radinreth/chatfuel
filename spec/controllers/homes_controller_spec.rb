RSpec.describe HomesController do
  describe 'routes' do
    it { should route(:get, '/').to(action: :show) }
  end
end
