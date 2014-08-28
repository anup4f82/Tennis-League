
get '/' do
  erb :index
end

get '/user/:id' do
  @id = params[:id]
  @user = User.find_by_id(@id)
  @scores = Score.where("winner_id = #{@id} or loser_id = #{@id} ")
  erb :profile
end

post '/user/:id' do
   id = params[:id]
   username = params[:username]        
   password = params[:password]
   firstname = params[:firstname]
   lastname = params[:lastname]
   phone = params[:phone]
   email = params[:email]
   address = params[:address]
   city = params[:city]
   state = params[:state]
   zip = params[:zip]
   rating = params[:rating].to_f
   location = params[:location]
   day = params[:day]
   player = params[:player]
   shot = params[:shot]
   User.find_by_id(id).update_attributes(username:username,password:password,firstname:firstname,lastname:lastname,phone:phone,email:email,address:address,city:city,state:state,zip:zip,rating:rating,location:location,day:day,player:player,shot:shot)
   redirect to "/user/success/#{id}"

end

get '/user/success/:id' do
  @success = true
  @id = params[:id]
  @user = User.find_by_id(@id)
  @scores = Score.where("winner_id = #{@id} or loser_id = #{@id} ")
  erb :profile
end

get '/sign-up' do
  erb :sign_up
end

post '/sign-up' do

   u = User.new
   u.username = params[:username]        
   u.password = params[:password]
   u.firstname = params[:firstname]
   u.lastname = params[:lastname]
   u.phone = params[:phone]
   u.email = params[:email]
   u.address = params[:address]
   u.city = params[:city]
   u.state = params[:state]
   u.zip = params[:zip]
   u.rating = params[:rating]
   u.location = params[:location]
   u.day = params[:day]
   u.player = params[:player]
   u.shot = params[:shot]
   u.noofwins = 0
   u.noofmatches = 0


# NEED to Move to USER MODEL
  if (u.rating.to_f >= 3.5)
    u.leagueno = 1
     u.save!
     session[:user_id] = u.id
    redirect to '/sign-in'
  else
    u.leagueno = 2
    u.save!
    redirect to '/sign-in'
    session[:user_id] = u.id
  end

end

get '/sign-in' do
  erb :sign_in
end

 post '/sign-in' do
  u = User.find_by_username(params[:username])
  if(u.nil?)
    @username = false
    erb :sign_in
  else
    if (u.password == params[:password])
      session[:user_id] = u.id
      redirect to '/'
    else
      @password = false
      erb :sign_in
    end
   end
   
end

 delete '/sign-out/:id' do
   session[:user_id] = nil
  redirect to '/'
 end

get '/advanced' do
  @advanced = User.where(leagueno:"1")
  @advanced = @advanced.sort_by{|x| x.noofwins}
  @advanced.reverse!
  erb :list
end

get '/comp' do
  @comp = User.where(leagueno:"2")
  @comp = @comp.sort_by{|x| x.noofwins}
  @comp.reverse!
  erb :list
end

post '/contact/:id' do
  @id = params[:id]
  @user = User.find_by_id(@id)
  erb :contact
end


post '/message/:id' do
  @id = params[:id]
  @message = params[:message]
  @time = params[:playtime]
  @message = "From #{current_user.firstname} - #{@message}"
  Message.create(user_id: @id,message: @message,time_proposed: @time,contact_user_id: current_user.id )
  redirect to '/'
end

get '/messages/:id' do
  @id = params[:id]
  @messages = Message.where(user_id:@id)
  erb :message
end


get '/user/:id/score' do

  @id = params[:id]
  @users = User.all
  erb :scores
  end

post '/user/:id/score' do
  @id = params[:id]
  # Need to create a method in user Model...
  @winner = params[:win]
  @loser = params[:loss]
  score = "#{params[:first_one]}-#{params[:first_two]},#{params[:second_one]}-#{params[:second_two]}-#{params[:third_one]}-#{params[:third_two]}"
  winner = User.find_by_id(@winner)
  winner.noofwins+=1
  winner.noofmatches+=1
  User.find_by_id(@winner).update_attributes(noofwins:winner.noofwins,noofmatches:winner.noofmatches)
  loser =  User.find_by_id(@loser)
  loser.noofmatches+=1
  User.find_by_id(@loser).update_attributes(noofwins:loser.noofwins,noofmatches:loser.noofmatches)
  content = "#{winner.firstname} defeats #{loser.firstname},Score: #{score}"
  Score.create(content: content,winner_id: @winner,loser_id: @loser)
  redirect to "/user/#{@id}/score"
end

post '/reminder/:id' do
  # Twilio -API Call
  # Need to move lot of logic to Model
  puts "HELLO"
  puts params
  @id = params[:id]
  puts @id

  response = params[:response]
  puts response
  if response == 'yes'
    Message.find_by_id(@id.to_i).update_attributes(playing:true)
    m = Message.find(@id)
    response_phone = User.find(m.user_id).phone
    contact_phone = User.find(m.contact_user_id).phone
    response_name = User.find(m.user_id).firstname
    contact_name = User.find(m.contact_user_id).firstname
    # Call text method in message Model
    text(response_phone,contact_phone,response_name,contact_name)
     m.destroy
    return{id:@id}.to_json
    # redirect to '/'

  end
 end



