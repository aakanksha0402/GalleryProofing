require 'rails_helper'

RSpec.describe "client_views/show", type: :view do
  before(:each) do
    @client_view = assign(:client_view, ClientView.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
