require 'rails_helper'

RSpec.describe "default_receipient_types/index", type: :view do
  before(:each) do
    assign(:default_receipient_types, [
      DefaultReceipientType.create!(
        :name => "Name",
        :active => false
      ),
      DefaultReceipientType.create!(
        :name => "Name",
        :active => false
      )
    ])
  end

  it "renders a list of default_receipient_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
