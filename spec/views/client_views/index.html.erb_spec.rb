require 'rails_helper'

RSpec.describe "client_views/index", type: :view do
  before(:each) do
    assign(:client_views, [
      ClientView.create!(),
      ClientView.create!()
    ])
  end

  it "renders a list of client_views" do
    render
  end
end
