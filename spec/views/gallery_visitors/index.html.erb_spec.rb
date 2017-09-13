require 'rails_helper'

RSpec.describe "gallery_visitors/index", type: :view do
  before(:each) do
    assign(:gallery_visitors, [
      GalleryVisitor.create!(
        :email => "Email",
        :gallery => nil
      ),
      GalleryVisitor.create!(
        :email => "Email",
        :gallery => nil
      )
    ])
  end

  it "renders a list of gallery_visitors" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
