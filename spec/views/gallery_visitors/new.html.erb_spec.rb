require 'rails_helper'

RSpec.describe "gallery_visitors/new", type: :view do
  before(:each) do
    assign(:gallery_visitor, GalleryVisitor.new(
      :email => "MyString",
      :gallery => nil
    ))
  end

  it "renders new gallery_visitor form" do
    render

    assert_select "form[action=?][method=?]", gallery_visitors_path, "post" do

      assert_select "input#gallery_visitor_email[name=?]", "gallery_visitor[email]"

      assert_select "input#gallery_visitor_gallery_id[name=?]", "gallery_visitor[gallery_id]"
    end
  end
end
