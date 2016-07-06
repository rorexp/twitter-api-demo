require 'rails_helper'

RSpec.describe "videos/new", type: :view do
  before(:each) do
    assign(:video, Video.new(
      :src => "MyString",
      :title => "MyString"
    ))
  end

  it "renders new video form" do
    render

    assert_select "form[action=?][method=?]", videos_path, "post" do

      assert_select "input#video_src[name=?]", "video[src]"

      assert_select "input#video_title[name=?]", "video[title]"
    end
  end
end
