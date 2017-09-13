require 'rails_helper'

RSpec.describe "dashboards/show", type: :view do
  before(:each) do
    @dashboard = assign(:dashboard, Dashboard.create!(
      :show_video => "",
      :add_gallery => false,
      :upload_photos => false,
      :customize_watermark => false,
      :setup_colo_logo => false,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
