require 'rails_helper'

RSpec.describe "correspondances/show", type: :view do
  before(:each) do
    @correspondance = assign(:correspondance, Correspondance.create!(
      :user1 => nil,
      :user2 => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
