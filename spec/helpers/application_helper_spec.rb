RSpec.describe ApplicationHelper do
 
  before do
    allow(controller).to receive(:controller_path).and_return 'Homes'
    allow(controller).to receive(:action_name).and_return 'index'
  end

  it '#css_class_name' do
    expect(helper.css_class_name).to eq 'homes-index'
  end

  it '#render_notice' do
    html = '<p class="notice">success</p>'

    allow(controller).to receive(:notice).and_return 'success'

    expect(helper.render_notice).to eq html
  end

  it '#render_alert' do
    html = '<p class="alert">fail</p>'

    allow(controller).to receive(:alert).and_return 'fail'

    expect(helper.render_alert).to eq html
  end
end
