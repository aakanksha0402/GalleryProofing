require 'rails_helper'

RSpec.describe "client_views/new", type: :view do
  before(:each) do
    assign(:client_view, ClientView.new())
  end

  it "renders new client_view form" do
    render

    assert_select "form[action=?][method=?]", client_views_path, "post" do
    end
  end
end
