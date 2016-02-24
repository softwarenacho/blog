enable :sessions

get '/register' do
  erb :register
end

post '/login' do
  puts "ENTRE A LOGIN"
  email = params[:user]
  pwd = params[:pwd]
  user = User.find_by(email: email)
  puts "User #{user}"
  if user == nil
    result = "User does not exist"
  else
    if pwd == user.pwd
      session[:user] ||= user.email
      session[:id] ||= user.id
      session[:name] ||= user.name
      redirect to('/home')
    else
      result = "Password incorrect"
    end
  end
end

post '/save_user' do
  name = params[:name]
  email = params[:email]
  pwd1 = params[:pwd1]
  pwd2 = params[:pwd2]
  email_exist = User.find_by(email: email)
  if (pwd1 != pwd2)
    result = "Your passwords do not match, please retype."
  elsif email_exist != nil
    result = "Your email is already registered."
  else
    user = User.new(name: name, email: email, pwd: pwd1)
    if user.save!
      session.clear
      session[:user] ||= user.email
      session[:id] ||= user.id
      session[:name] ||= user.name
      puts session[:name]
      redirect to('/home')
    end
  end
end

get '/home' do
  puts "ENTRE A HOME"
  @name = session[:name]
  @id = session[:id]
  puts "ID #{@id} y #{@name}"
  @posts = Post.where("users_id = ?", @id)
  puts "POST #{@posts}"
  erb :home
end

get '/logout' do
  session.clear
  erb :index
end