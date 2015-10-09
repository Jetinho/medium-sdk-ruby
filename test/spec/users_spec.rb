require 'minitest_helper'

# MediumSpec is used to test the main Medium SDK Client
module MediumSpec
  describe 'Medium Users Client', 'The Medium SDK Gem Users Resource Client' do
    before do
      auth = { integration_token: ENV['integration_token'] }
      @client = Medium::Client.new auth
      @users_client = @client.users
    end

    it 'should initialize the correct type of client object' do
      expect(@users_client).must_be_instance_of Medium::Users
    end

    it 'should retrieve the currently authorized user account' do
      response = {
        'data' => {
          'id' => '1008821ef02b8f33ad7b7c8c8c0a3153d2f954e292771b61c4769522a5097eaac',
          'username' => 'kkirsche',
          'name' => 'Kevin Kirsche',
          'url' => 'https://medium.com/@kkirsche',
          'imageUrl' => 'https://cdn-images-1.medium.com/fit/c/200/200/1*dmbNkD5D-u45r44go_cf0g.png'
        }
      }
      expect(@users_client.me).must_equal response
    end

    it 'should return a runtime error when it has an invalid authorization token' do
      auth = { integration_token: 'test' }
      client = Medium::Client.new auth
      expect(proc { client.users.me }).must_raise RuntimeError
    end
  end
end
