require 'rails_helper'

RSpec.describe "music_categories/edit", type: :view do
  before(:each) do
    @music_category = assign(:music_category, MusicCategory.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit music_category form" do
    render

    assert_select "form[action=?][method=?]", music_category_path(@music_category), "post" do

      assert_select "input#music_category_name[name=?]", "music_category[name]"
    end
  end
end
