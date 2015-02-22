ApiTaster.global_headers = {
  'Authorization' => 'Bearer 86a60aa74e3966479527cddf75eafbc279593a2ccabe05ddbf9b31fb94bee754'
}

ApiTaster.routes do
    desc 'New user session'

    post '/oauth/token', {
        :format => :json,
        :grant_type => "password",
        :client_id => "e3fccc07f8a8df6e60db808dfa54fe0c6429f7a3a3e015c45f3f48c7d47e18fd",
        :client_secret => "749c5eb50882ad23f45c0b0dae17af6a95e4db1563f16c91a5da6517fcfa44a4",
        :email => "sam@example.com",
        :password => "passwordexample"
    }

    post '/oauth/revoke', {
        :format => :json,
        :token => ""
    }

    desc 'Destroy user session'

    delete '/users/sign_out', {
        :format => :json,
        :access_token => ""
    }

    desc 'Cancel user registration'

    delete '/users', {

    }

    desc 'New user registration'

    post '/users', { 
        :format => :json,
        :user => {
            :email => 'sam@example.com',
            :password => 'passwordexample',
            :password_confirmation => 'passwordexample'
        }
    }

    desc 'Edit user registration'

    put '/users', {

    }

    desc 'Create user password'

    post '/users/password', {

    }

    desc 'Edit user password'

    put '/users/password', {

    }


    
end
=begin
  
    get '/users'

    post '/users', {
      :user => {
        :name => 'Fred'
      }
    }

    get '/users/:id', {
      :id => 1
    }

    put '/users/:id', {
      :id => 1, :user => {
        :name => 'Awesome'
      }
    }

    delete '/users/:id', {
      :id => 1
    }
=end