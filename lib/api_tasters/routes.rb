ApiTaster.routes do
    desc 'New user session'

    post '/users/sign_in', {

    }

    desc 'Destroy user session'

    delete '/users/sign_out', {

    }

    desc 'Cancel user registration'

    delete '/users', {

    }

    desc 'New user registration'

    post '/users', {

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