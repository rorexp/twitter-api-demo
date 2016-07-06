require 'rails_helper'

RSpec.describe "videos/edit", type: :view do
  before(:each) do
    @video = assign(:video, Video.create!(
      :src => "MyString",
      :title => "MyString"
    ))
  end

  it "renders the edit video form" do
    render

    assert_select "form[action=?][method=?]", video_path(@video), "post" do

      assert_select "input#video_src[name=?]", "video[src]"

      assert_select "input#video_title[name=?]", "video[title]"
    end
  end
end
