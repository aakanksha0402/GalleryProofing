require 'rails_helper'

RSpec.describe "dashboards/index", type: :view do
  before(:each) do
    assign(:dashboards, [
      Dashboard.create!(
        :show_video => "",
        :add_gallery => false,
        :upload_photos => false,
        :customize_watermark => false,
        :setup_colo_logo => false,
        :user => nil
      ),
      Dashboard.create!(
        :show_video => "",
        :add_gallery => false,
        :upload_photos => false,
        :customize_watermark => false,
        :setup_colo_logo => false,
        :user => nil
      )
    ])
  end

  it "renders a list of dashboards" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
