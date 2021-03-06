require 'rails_helper'

RSpec.describe "galleries/show", type: :view do
  before(:each) do
    @gallery = assign(:gallery, Gallery.create!(
      :name => "Name",
      :cover_url => "Cover Url",
      :archive => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Cover Url/)
    expect(rendered).to match(/false/)
  end
end
