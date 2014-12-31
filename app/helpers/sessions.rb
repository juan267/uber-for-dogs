helpers do

  def current_owner
    if session[:owner_id]
      @current_owner = Owner.find(session[:owner_id])
      return @current_owner
    else
      nil
    end
  end

end