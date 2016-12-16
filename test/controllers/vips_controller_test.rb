require 'test_helper'

class VipsControllerTest < ActionDispatch::IntegrationTest
  test "attempt to get vip index" do
    get "/vips.json"
    assert_response :success
  end

=begin
  test "attempt to show vip" do
    get "/vips/1.json"
    assert_response
  end
=end

  test "attempt to create new Vip" do
    get "/vips/new"
    assert_response :success
  end

  #test "attemp to update Vip" do
  #  patch "/vips/1.json"
  #  assert_response :success
  #end

  test "attempt to access home page" do
    get "/"
    assert_select "h1", "Project FR"
  end

  test "attempt to create a VIP" do
    get "/vips/new"
    assert_response :success

    post "/vips", params: {
      vip: {
        img_name: "matching[image]",
        img_type: "image/png",
        img_data: "...",
        size: "6",
        image: "test.png"
        }
      }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "VIP can be created"
  end

end
=begin
setup do
  @vip = vips(:one)
end

test "should get index" do
  get vips_url
  assert_response :success
end

test "should get new" do
  get new_vip_url
  assert_response :success
end

test "should create vip" do
  assert_difference('Vip.count') do
    post vips_url, params: { vip: { img_data: @vip.img_data, img_name: @vip.img_name, img_type: @vip.img_type, size: @vip.size } }
  end

  assert_redirected_to vip_url(Vip.last)
end

test "should show vip" do
  get vip_url(@vip)
  assert_response :success
end

test "should get edit" do
  get edit_vip_url(@vip)
  assert_response :success
end

test "should update vip" do
  patch vip_url(@vip), params: { vip: { img_data: @vip.img_data, img_name: @vip.img_name, img_type: @vip.img_type, size: @vip.size } }
  assert_redirected_to vip_url(@vip)
end

test "should destroy vip" do
  assert_difference('Vip.count', -1) do
    delete vip_url(@vip)
  end

  assert_redirected_to vips_url
end
=end
