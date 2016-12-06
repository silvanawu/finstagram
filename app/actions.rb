helpers do
    def current_user
        User.find_by(id: session[:user_id])
    end
end

def humanized_time_ago(time_ago_in_minutes)
    if time_ago_in_minutes >= 60
        "#{time_ago_in_minutes / 60} hours ago"
    else
        "#{time_ago_in_minutes} minutes ago"
    end
end

get '/' do
  #   @post_shark = {    
  #   username: "sharky_j",
  #   avatar_url: "http://naserca.com/images/sharky_j.jpg",
  #   photo_url: "http://naserca.com/images/shark.jpg",
  #   humanized_time_ago: humanized_time_ago(15),
  #   like_count: 0,
  #   comment_count: 1,
  #   comments: [{
  #       username: "shark_j",
  #       text: "Out for the long weekend... too embarassed to show y'all the beach bod!"
  #       }]
  #   }
    
  #   @post_whale = {    
  #   username: "kirk_whalum",
  #   avatar_url: "http://naserca.com/images/kirk_whalum.jpg",
  #   photo_url: "http://naserca.com/images/whale.jpg",
  #   humanized_time_ago: humanized_time_ago(65),
  #   like_count: 0,
  #   comment_count: 1,
  #   comments: [{
  #     username: "kirk_whalum",
  #     text: "#weekendvibes"
  #       }]
  #   }
    
  #   @post_marlin = {    
  #   username: "marlin_peppa",
  #   avatar_url: "http://naserca.com/images/marlin_peppa.jpg",
  #   photo_url: "http://naserca.com/images/marlin.jpg",
  #   humanized_time_ago: humanized_time_ago(190),
  #   like_count: 0,
  #   comment_count: 1,
  #   comments: [{
  #     username: "marlin_peppa",
  #     text: "#lunchtime! ;)"
  #       }]
  #   }

  # @posts = [@post_shark, @post_whale, @post_marlin]
  
  @posts = Post.order(created_at: :desc)
  erb(:index)
  
end  

get '/signup' do
    @user = User.new
    erb(:signup)
end

post '/signup' do
    email = params[:email]
    avatar_url = params[:avatar_url]
    username = params[:username]
    password = params[:password]
    
    @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password})
    
    if @user.save
      redirect to('/login')
    else
      erb(:signup)
    end
end

get '/login' do
  erb(:login)
  #params.to_s
end

post '/login' do
    username = params[:username]
    password = params[:password]
    
    user = User.find_by(username: username)
    
    if user && user.password == password
        session[:user_id] = user.id
        redirect to('/')
    else
        @error_message = "Login Failed"
        erb(:login)
    end
end

get '/logout' do
    session[:user_id] = nil
    redirect to('/')
end

get '/' do
    @posts = Post.order(created_at: :desc)
    erb(:index)
end
    
get '/posts/new' do
    @post = Post.new
    erb(:"posts/new")
end

post '/posts/new' do
    photo_url = params[:photo_url]
    @post = Post.new({ photo_url: photo_url, user_id: current_user.id})
    if @post.save
        redirect(to('/'))
    else
        @post.errors.full_messages.inspect
    end
end

get '/posts/:id' do
    @post = Post.find(params[:id]) #find the post with the ID from the URL
    erb(:"posts/show")
end

post '/comments' do
    text = params[:text]
    post_id = params[:post_id]
    
    comment = Comment.new({ text: text, post_id: post_id, user_id: current_user.id })
    comment.save
    redirect (back)
end

post '/likes' do
    post_id = params[:post_id]
    
    like = Like.new({ post_id: post_id, user_id: current_user.id })
    like.save
    redirect (back)
end

delete '/likes/:id' do
    like = Like.find(params[:id])
    like.destroy
    redirect(back)
end




