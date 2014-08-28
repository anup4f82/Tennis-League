helpers do
# TODO: return the current user if there is a user signed in.
  def current_user
  	if session[:user_id].nil?
    false
    else 
    	puts "BEFORE"
   p session[:user_id]
   puts "AFTER"
    return User.find_by_id(session[:user_id])
   end

end
end
