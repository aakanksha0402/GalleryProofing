require 'rails_helper'

RSpec.describe "categories/edit", type: :view do
  before(:each) do
    @category = assign(:category, Category.create!(
      :name => "MyString",
      :brand => nil
    ))
  end

  it "renders the edit category form" do
    render

    assert_select "form[action=?][method=?]", category_path(@category), "post" do

      assert_select "input#category_name[name=?]", "category[name]"

      assert_select "input#category_brand_id[name=?]", "category[brand_id]"
    end
  end
end
