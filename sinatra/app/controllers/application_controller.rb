class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::Namespace

  before do 
    content_type 'application/vnd.api+json'
  end

  # Configure Warden
  use Warden::Manager do |config|
    config.scope_defaults :default,
                          # Set your authorization strategy
                          strategies: [:access_token],
                          # Route to redirect to when warden.authenticate! returns a false answer.
                          action: '/unauthenticated'
    config.failure_app = self
  end

  post '/unauthenticated' do
    status 401
    {
      errors: [
        {
          status: 401,
          title: 'Unauthenticated',
          detail: 'You must provide a valid access token'
        }
      ]
    }.to_json
  end

  Warden::Manager.before_failure do |env|
    env['REQUEST_METHOD'] = 'POST'
  end

  # Implement your Warden stratagey to validate and authorize the access_token.
  Warden::Strategies.add(:access_token) do
    def valid?
      # Validate that the access token is properly formatted.
      # Currently only checks that it's actually a string.
      request.env['HTTP_AUTHORIZATION'].is_a?(String)
    end

    def authenticate!
      access_token = request.env['HTTP_AUTHORIZATION'].split(' ').last
      access_granted = User.find_by(username: Helpers::TokenHelper.decode_token(access_token)) ? true : false
      access_granted ? success!(access_granted) : fail!('Could not log in')
    end
  end
end