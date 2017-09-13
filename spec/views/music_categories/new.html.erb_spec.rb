require 'rails_helper'

RSpec.describe "music_categories/new", type: :view do
  before(:each) do
    assign(:music_category, MusicCategory.new(
      :name => "MyString"
    ))
  end

  it "renders new music_category form" do
    render

    assert_select "form[action=?][method=?]", music_categories_path, "post" do

      assert_select "input#music_category_name[name=?]", "music_category[name]"
    end
  end
end
