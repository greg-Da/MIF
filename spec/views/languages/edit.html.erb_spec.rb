require 'rails_helper'

RSpec.describe "languages/edit", type: :view do
  before(:each) do
    @language = assign(:language, Language.create!(
      :language => "MyString",
      :user => nil
    ))
  end

  it "renders the edit language form" do
    render

    assert_select "form[action=?][method=?]", language_path(@language), "post" do

      assert_select "input[name=?]", "language[language]"

      assert_select "input[name=?]", "language[user_id]"
    end
  end
end
