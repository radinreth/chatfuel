RSpec.describe ApplicationHelper do
  it '#css_class_name' do
    allow(controller).to receive(:controller_path).and_return 'Homes'
    allow(controller).to receive(:action_name).and_return 'index'

    expect(helper.css_class_name).to eq 'homes-index'
  end

  it '#render_notice' do
    html = '<div class="alert alert-primary" role="alert">success</div>'

    allow(controller).to receive(:notice).and_return 'success'

    expect(helper.render_notice).to eq html
  end

  it '#render_alert' do
    html = '<div class="alert alert-danger" role="alert">fail</div>'

    allow(controller).to receive(:alert).and_return 'fail'

    expect(helper.render_alert).to eq html
  end
end
