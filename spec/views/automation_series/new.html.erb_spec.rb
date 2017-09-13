require 'rails_helper'

RSpec.describe "automation_series/new", type: :view do
  before(:each) do
    assign(:automation_series, AutomationSeries.new(
      :name => "MyString"
    ))
  end

  it "renders new automation_series form" do
    render

    assert_select "form[action=?][method=?]", automation_series_index_path, "post" do

      assert_select "input#automation_series_name[name=?]", "automation_series[name]"
    end
  end
end
