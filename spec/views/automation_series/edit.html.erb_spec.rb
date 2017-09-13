require 'rails_helper'

RSpec.describe "automation_series/edit", type: :view do
  before(:each) do
    @automation_series = assign(:automation_series, AutomationSeries.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit automation_series form" do
    render

    assert_select "form[action=?][method=?]", automation_series_path(@automation_series), "post" do

      assert_select "input#automation_series_name[name=?]", "automation_series[name]"
    end
  end
end
