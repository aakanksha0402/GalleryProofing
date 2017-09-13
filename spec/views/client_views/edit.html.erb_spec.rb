require 'rails_helper'

RSpec.describe "client_views/edit", type: :view do
  before(:each) do
    @client_view = assign(:client_view, ClientView.create!())
  end

  it "renders the edit client_view form" do
    render

    assert_select "form[action=?][method=?]", client_view_path(@client_view), "post" do
    end
  end
end
