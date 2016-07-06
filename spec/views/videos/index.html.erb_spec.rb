require 'rails_helper'

RSpec.describe "videos/index", type: :view do
  before(:each) do
    assign(:videos, [
      Video.create!(
        :src => "Src",
        :title => "Title"
      ),
      Video.create!(
        :src => "Src",
        :title => "Title"
      )
    ])
  end

  it "renders a list of videos" do
    render
    assert_select "tr>td", :text => "Src".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
