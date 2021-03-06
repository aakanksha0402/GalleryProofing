require 'rails_helper'

RSpec.describe "dashboards/new", type: :view do
  before(:each) do
    assign(:dashboard, Dashboard.new(
      :show_video => "",
      :add_gallery => false,
      :upload_photos => false,
      :customize_watermark => false,
      :setup_colo_logo => false,
      :user => nil
    ))
  end

  it "renders new dashboard form" do
    render

    assert_select "form[action=?][method=?]", dashboards_path, "post" do

      assert_select "input#dashboard_show_video[name=?]", "dashboard[show_video]"

      assert_select "input#dashboard_add_gallery[name=?]", "dashboard[add_gallery]"

      assert_select "input#dashboard_upload_photos[name=?]", "dashboard[upload_photos]"

      assert_select "input#dashboard_customize_watermark[name=?]", "dashboard[customize_watermark]"

      assert_select "input#dashboard_setup_colo_logo[name=?]", "dashboard[setup_colo_logo]"

      assert_select "input#dashboard_user_id[name=?]", "dashboard[user_id]"
    end
  end
end
