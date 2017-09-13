require 'rails_helper'

RSpec.describe "gallery_visitors/edit", type: :view do
  before(:each) do
    @gallery_visitor = assign(:gallery_visitor, GalleryVisitor.create!(
      :email => "MyString",
      :gallery => nil
    ))
  end

  it "renders the edit gallery_visitor form" do
    render

    assert_select "form[action=?][method=?]", gallery_visitor_path(@gallery_visitor), "post" do

      assert_select "input#gallery_visitor_email[name=?]", "gallery_visitor[email]"

      assert_select "input#gallery_visitor_gallery_id[name=?]", "gallery_visitor[gallery_id]"
    end
  end
end
