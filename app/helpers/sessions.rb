helpers do

  def current_owner
    if session[:owner_id]
      @current_owner = Owner.find(session[:owner_id])
      return @current_owner
    else
      nil
    end
  end

  def current_walker
    if session[:walker_id]
      @current_walker = Walker.find(session[:walker_id])
      return @current_walker
    else
      nil
    end
  end

end