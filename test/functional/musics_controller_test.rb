require 'test_helper'

class MusicsControllerTest < ActionController::TestCase
  setup do
    @music = musics(:one)
    @music_new = Music.new(
                  :author => 'Diogo',
                  :description => "Diogo's masterpiece",
                  :downloadable => 'true',
                  :length => 123,
                  :title => 'Drop the beat'
              )
  end
=begin
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:musics)
  end
=end
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create music" do
    assert_difference('Music.count') do
      #file = Rack::Test::UploadedFile.new('files/folder.jpg', "image/jpg")
      @file = fixture_file_upload('files/folder.jpg','image/jpg')
      post :create, music: @music_new.attributes, file: @file
    end

    assert_redirected_to home_url # music_path(assigns(:music))
  end

=begin
  test "should show music" do
    get :show, id: @music.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @music.to_param
    assert_response :success
  end


  test "should update music" do
    put :update, id: @music.to_param, music: @music.attributes
    assert_redirected_to listen_path(assigns(:music))
  end
=end
  test "should destroy music" do
    assert_difference('Music.count', -1) do
      delete :destroy, id: @music.to_param
    end

    assert_redirected_to home_url
  end
end
