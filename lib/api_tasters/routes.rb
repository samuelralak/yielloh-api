ApiTaster.global_headers = {
  
}

ApiTaster.routes do
    desc 'USER SIGN IN'

    post '/oauth/token', {
        :format => :json,
        :grant_type => "password",
        :client_id => "e3fccc07f8a8df6e60db808dfa54fe0c6429f7a3a3e015c45f3f48c7d47e18fd",
        :client_secret => "749c5eb50882ad23f45c0b0dae17af6a95e4db1563f16c91a5da6517fcfa44a4",
        :email => "sam@example.com",
        :password => "passwordexample"
    }

    desc 'USER SIGN OUT'

    delete '/user_sessions/:id', {
        :format => :json,
        :access_token => "3560ec9cbb129196f3550ae6e612f439fd089d73464df4cd7d3aaa7dde34341f",
        :id => "4e4671e9-6829-4d98-ae40-f269ecde7762"
    }

    desc 'NEW USER REGISTRATION'

    post '/users', { 
        :format => :json,
        :user => {
            :email => 'sam@example.com',
            :password => 'passwordexample',
            :password_confirmation => 'passwordexample'
        }
    }

    
end