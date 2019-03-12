require 'rails_helper'

RSpec.describe "correspondances/edit", type: :view do
  before(:each) do
    @correspondance = assign(:correspondance, Correspondance.create!(
      :user => nil,
      :user => nil
    ))
  end

  it "renders the edit correspondance form" do
    render

    assert_select "form[action=?][method=?]", correspondance_path(@correspondance), "post" do

      assert_select "input[name=?]", "correspondance[user_id]"

      assert_select "input[name=?]", "correspondance[user_id]"
    end
  end
end
