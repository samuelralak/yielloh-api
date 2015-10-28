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

    desc 'REFRESH TOKEN'

    post '/oauth/token', {
        :format => :json,
        :grant_type => "refresh_token",
        :client_id => "e3fccc07f8a8df6e60db808dfa54fe0c6429f7a3a3e015c45f3f48c7d47e18fd",
        :client_secret => "749c5eb50882ad23f45c0b0dae17af6a95e4db1563f16c91a5da6517fcfa44a4",
        :refresh_token => "",
        :password => "passwordexample"
    }

    desc 'USER SIGN OUT'

    delete '/user_sessions', {
        :format => :json,
        :access_token => "3560ec9cbb129196f3550ae6e612f439fd089d73464df4cd7d3aaa7dde34341f"
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

    desc 'USER PROFILE'

    post '/profiles', {
        :format => :json,
        :access_token => "3560ec9cbb129196f3550ae6e612f439fd089d73464df4cd7d3aaa7dde34341f",
        :profile => {
            :fullname => '',
            :username => '',
            :about => '',
            :location => '',
            :user_id => '4023de7b-cc16-4455-a40f-21814afeda47'
        }
    }

    get '/profiles/:id', {
        :format => :json,
        :access_token => "3560ec9cbb129196f3550ae6e612f439fd089d73464df4cd7d3aaa7dde34341f",
        :id => ""
    }

    patch '/profiles/:id', {
        :format => :json,
        :id => "",
        :access_token => "3560ec9cbb129196f3550ae6e612f439fd089d73464df4cd7d3aaa7dde34341f",
        :profile => {
            :fullname => '',
        }
    }

    put '/profiles/:id', {
        :format => :json,
        :id => "",
        :access_token => "3560ec9cbb129196f3550ae6e612f439fd089d73464df4cd7d3aaa7dde34341f",
        :profile => {
            :username => '',
        }
    }

    
end