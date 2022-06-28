role :app, %w{49.212.167.121}
role :web, %w{49.212.167.121}
role :db,  %w{49.212.167.121}

set :password, ask('Server password', nil)
server '49.212.167.121', user: 'attendance_management', password: fetch(:password), roles: %w{web app db}
