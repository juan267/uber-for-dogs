get '/' do
  erb :index
end

# ----------Sessions-------
get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
  @owner = Owner.find_by(email: params[:email])
  @walker = Walker.find_by(email: params[:email])
  if @owner
    if @owner.authenticate(params[:password])
      session[:owner_id] = @owner.id
      redirect '/'
    else
      @error = "wrong password"
      erb :sign_in
    end
  elsif @walker
    if @walker.authenticate(params[:password])
      session[:walker_id] = @walker.id
      redirect "/walkers/#{current_walker.id}"
    else
      @error = "wrong password"
      erb :sign_in
    end
  else
    @error = "wrong email"
    erb :sign_in
  end
end

delete '/sessions/delete' do
  if current_owner
    session[:owner_id] = nil
    redirect '/'
  else
    session[:walker_id] = nil
    redirect '/'
  end
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
    redirect "/owners/#{current_owner}/dogs"
  else
    @errors = @owner.errors[:email][0]
    content_type :json
    {error: true, message:@errors}.to_json
  end
end

#----------DOGS--------------

get '/owners/:id/dogs' do
  @owner = Owner.find(params[:id])
  @dogs = @owner.dogs
  erb :show_dogs
end

get '/owners/:id/dogs/new' do
  @owner = Owner.find(params[:id])
  erb :_add_dog_form, layout: false
end

post '/owners/:id/dogs' do
  @dog = current_owner.dogs.create(params[:dog])
  content_type :json
  {name: @dog.name, dog_id:@dog.id, owner_id:current_owner.id}.to_json
end

get '/owners/:id/dogs/:dog_id/edit' do
  @owner = Owner.find(params[:id])
  @dog = Dog.find(params[:dog_id])
  erb :_edit_dog_form, layout: false
end

get '/owners/:id/dogs/:dog_id' do
  @dog = Dog.find(params[:dog_id])
  @walkers = @dog.walkers
  @walk = @dog.walks.last
  erb :dog_profile
end

post '/owners/:owner_id/dogs/:dog_id/walks' do
  @dog = Dog.find(params[:dog_id])
  p params
  @walk = @dog.walks.create(walker_id: 1, pick_up_time:params[:pick_up_time]) #hard coded
  @walker = Walker.find(1) #hard coded
  coord = Coord.create(latitude:params[:lat], longitude:params[:lng], walk_id: @walk.id)
  erb :_first_walk, layout: false
end

get '/owners/:owner_id/dogs/:dog_id/walks/active' do
  @dog = Dog.find(params[:dog_id])
  @walk = @dog.walks.where(status:"active").take
  distance = @walk.distance
  path = [@walk.path[-2], @walk.path[-1]]
  content_type :json
  {path: path, distance: distance, }.to_json
end

put '/owners/:id/dogs/:dog_id' do
  @dog = Dog.find(params[:dog_id])
  @dog.update(params[:dog])
  content_type :json
  {name: @dog.name, id:params[:id], dog_id:params[:dog_id]}.to_json
end

#-----------MAP--------------------

get '/walkers/:walker_id/dogs/:dog_id/walks/:walk_id/map' do
  @walker = current_walker
  @walk = Walk.find(params[:walk_id])
  @dog = Dog.find(params[:dog_id])
  erb :map
end

get '/coords' do
  walk = Walk.find(1)
  @path = walk.path
  content_type :json
  {path: @path}.to_json
end

post '/walkers/:id/dogs/:id/walk/:walk_id/coords/new' do
  walk = Walk.find(params[:walk_id])
  walk.status = "active"
  walk.save
  last_coord = walk.path[-1]
  coord = Coord.create(latitude:params[:lat], longitude:params[:lng], walk_id: walk.id)
  distance = walk.distance
  walk.status = "active"
  walk.save
  content_type :json
  path = [last_coord, [coord.latitude, coord.longitude]]
  p path
  {path: path, distance: distance}.to_json
end

#--------WALKER----------------------

get '/walkers/new' do
  erb :sign_up_walker
end

get '/walkers/:id' do
  @walker = Walker.find(params[:id])
  @dogs = @walker.dogs
  erb :walker_profile
end

post '/walkers' do
  @walker = Walker.create(params[:walker])
  if @walker.errors.empty?
    @walker.password=(@walker.password_hash)
    @walker.save
    session[:walker_id] = @walker.id
    content_type :json
    redirect "/walkers/#{current_walker}"
  else
    @errors = @walker.errors[:email][0]
    content_type :json
    {error: true, message:@errors}.to_json
  end
end






