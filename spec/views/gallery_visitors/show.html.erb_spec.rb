require 'rails_helper'

RSpec.describe "gallery_visitors/show", type: :view do
  before(:each) do
    @gallery_visitor = assign(:gallery_visitor, GalleryVisitor.create!(
      :email => "Email",
      :gallery => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(//)
  end
end
