require 'net/http'
require 'json'

=begin
MatchingsController CLASS
This class handles users' request and fetches the users' requesting image
to the projectoxford.ai/face/v1.0/detect for further facial recognition
and matching processes. The response from the API provider will be in json
format and the data will be parsed into class attribute for later usage (
to generate views)
=end

class MatchingsController < ApplicationController
	# PORT INFORMATION
	IP_PORT = 'http://67.188.93.111:3000'
	protect_from_forgery with: :null_session

	# METHOD new
	# When users attempt to create a new facial recognition request, This
	# method will be called
	def new
		@matching = Matching.new
		puts "**********************************"
		puts request.host_with_port
	end

	# empty show method
	def show
	end

	# Method create
	# This method is the core of the entire project. It would execute the
	# following tasks:
	# => create a new Matching object with the users' input (image)
	# => constructe URI for HTTP request
	# => API calls
	# => parse results for the generation of views
	def create
		@matching = Matching.new(matching_params)
		#Detect the face
		if @matching.save
			uri = URI('https://api.projectoxford.ai/face/v1.0/detect')
		    uri.query = URI.encode_www_form({
		        # Request parameters
		        'returnFaceId' => 'true'
		    })

		    request = Net::HTTP::Post.new(uri.request_uri)
		    # Request headers
		    request['Content-Type'] = 'application/json'
		    # Request headers
		    request['Ocp-Apim-Subscription-Key'] = '71e6768c33ae4b37b960d488c0b0ea17'
		    # Request body
		    request.body = {url: "#{IP_PORT}#{@matching.image.url}"}.to_json

		    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
		        http.request(request)
		    end

		    puts response.body
		    data = JSON.parse(response.body)
		    puts 'matchings_controller_create API: Face detect +++++++++++++++++++++++++++++++++++++++++++++++++++++'
		    puts "#{IP_PORT}#{@matching.image.url}"
		    @faceID = data[0]['faceId']
			puts '============================================================='
			puts @matching
			#puts params.inspect
			puts "________faceID________"
			puts @faceID

			#Find the face in faceList

			uri = URI('https://api.projectoxford.ai/face/v1.0/findsimilars')
			uri.query = URI.encode_www_form({
				# Request Parameters:
				'persistedFaceId' => 'string'
			})

			request = Net::HTTP::Post.new(uri.request_uri)
			# Request headers
			request['Content-Type'] = 'application/json'
			# Request headers
			request['Ocp-Apim-Subscription-Key'] = '71e6768c33ae4b37b960d488c0b0ea17'
			# Request body
			request.body = {
			    "faceId" => @faceID,
			    "faceListId" => "vips",
			    "maxNumOfCandidatesReturned" => 5,
			    "mode" => "matchFace"
			}.to_json

			response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
			    http.request(request)
			end
		    puts 'matchings_controller_create API: Face findSimilar +++++++++++++++++++++++++++++++++++++++++++++++++++++'
			puts response.body
			@face = Array.new
			@percentage = Array.new
			data = JSON.parse(response.body)
			data.each do |res|
				puts res['persistedFaceId']
				vip = Vip.find_by img_name: res['persistedFaceId']
				if vip != nil
					@face << vip
					@percentage << res['confidence']
					puts "Found: " + vip.img_name
					puts "Found: " + (res['confidence'] * 100 ).to_s
				end
			end

		end



	end
private
	# parsing users' inputs from the form
	def matching_params
      params.require(:matching).permit(:image)
  end
end
