require 'rails_helper'

RSpec.describe "tickets/new", type: :view do
  before(:each) do
    assign(:ticket, Ticket.new(
      :object => "MyString",
      :category => "MyString",
      :content => "MyText",
      :user => nil,
      :status => "MyString"
    ))
  end

  it "renders new ticket form" do
    render

    assert_select "form[action=?][method=?]", tickets_path, "post" do

      assert_select "input[name=?]", "ticket[object]"

      assert_select "input[name=?]", "ticket[category]"

      assert_select "textarea[name=?]", "ticket[content]"

      assert_select "input[name=?]", "ticket[user_id]"

      assert_select "input[name=?]", "ticket[status]"
    end
  end
end
