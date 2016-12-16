require 'test_helper'
require 'net/http'
require 'json'

class MatchingsControllerTest < ActionDispatch::IntegrationTest
  test "test MatchingsController new" do
    get "/"
    assert_response :success
  end

  test "attempt MatchingsController new" do
    get "/matchings/new"
    assert_response :success
  end

  #test "test MatchingsController create" do
  #  get "/matchings.json"
  #  assert_response :success
  #
  #  post_via_redirect "/matchings.json", index = "1"
  #  assert_equal "/matchings.json", path
  #  assert_response 400
  #end
=begin
# test "the truth" do
#   assert true
# end
IP_PORT = "http://67.188.93.111:3000"
protect_from_forgery with: :null_session

def setup
  @matching = Matching.new
end

# TEST - if Matching.new creates object
test "test matching new in function new" do
  assert_instance_of Matching, @matching, "Matching.new OK!"
end

# TEST - if @matching.save works
test "test matching save in function create" do
  @matching = Matching.new(matching_params)
  assert @matching.save, "Matching.save OK!"
end

# TEST - building URI body
test "test URI body construction" do
  @uri_body = {"#{IP_PORT}#{@matching.image.url}"}.to_json
  assert
end

# TEST - request object setup
test "test request object construction from URI" do
  @uri = URI('https://api.projectoxford.ai/face/v1.0/detect')
  @uri.query = URI.encode_www_form({
      #Request parameters
      'returnFaceId' => 'true'
    })
  @request = Net::HTTP::Post.new(uri.request_uri)
  @request['Content-Type'] = 'application/jason'
  @request['Ocp-Apim-Subscription-Key'] = '71e6768c33ae4b37b960d488c0b0ea17'
  @request.body = {
    url:
  }

end

# TEST - def create
test "test create function restful api calls" do

end
=end
end

=begin
def setup
  @matchings_controller = MatchingsController.new
end

def test_new
  assert_instance_of(
    Matching,
    @matchings_controller.matching,
    "MatchingsController does not have a Matching object called matching"
  )
end

def test_show
  assert true, "function-show is OK!"
end

def test_create
  @matchings_controller.create

  assert_empty(
    @matchings_controller.faceID,
    "MatchingsController.faceID can not be empty"
  )

  assert_empty(
    @matchings_controller.face,
    "MatchingsController.face can not be empty"
  )

  assert_empty(
    @matchings_controller.percentage,
    "MatchingsController.percentage can not be empty"
  )
end
=end

=begin
setup do
  #@matchings_controller = MatchingsController.new
  @matchings_controller = MatchingsController.new
  @matchings_controller.create
end

test "matching.new should return a Matching class object" do
  assert_instance_of(
    Matching,
    @matchings_controller.matching,
    "MatchingsController does not have a Matching object called matching"
  )
end

#test "test_show"
#  assert true, "function-show is OK!"
#end

test "faceID should not be empty" do
  assert_empty(
    @matchings_controller.faceID,
    "MatchingsController.faceID can not be empty"
  )
end

test "face array should not be empty" do
  assert_empty(
    @matchings_controller.face,
    "MatchingsController.face can not be empty"
  )
end

test "percentage array should not be empty" do
  assert_empty(
    @matchings_controller.percentage,
    "MatchingsController.percentage can not be empty"
  )
end
=end
