get '/' do
  erb :index
end

# ----------Sessions-------
get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
  @owner = Owner.find_by(email: params[:email])
  if @owner
    if @owner.authenticate(params[:password])
      session[:owner_id] = @owner.id
      redirect '/'
    else
      @error = "wrong password"
      erb :sign_in
    end
  else
    @error = "wrong email"
    erb :sign_in
  end
end

delete '/sessions/:id' do
  session[:owner_id] = nil
  redirect '/'
end




# ----------USERS----------

get '/owners/new' do
  erb :sign_up
end

post '/owners' do
  @owner = Owner.create(params[:owner])
  if @owner.errors.empty?
    @owner.password=(@owner.password_hash)
    @owner.save
    session[:owner_id] = @owner.id
    content_type :json
    {error: false}.to_json
  else
    @errors = @owner.errors[:email][0]
    content_type :json
    {error: true, message:@errors}.to_json
  end
end


