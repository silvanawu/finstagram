posts = [
    {
     username: "sharky_j", 
     avatar_url: "http://naserca.com/images/sharky_j.jpg",
     photo_url: "http://naserca.com/images/shark.jpg",
     humanized_time_ago: humanized_time_ago(15),
     like_count: 0,
     comment_count: 1,
    },
    {
     username: "kirk_whalum", 
     avatar_url: "http://naserca.com/images/kirk_whalum.jpg",
     photo_url: "http://naserca.com/images/whale.jpg",
     humanized_time_ago: humanized_time_ago(65),
     like_count: 0,
     comment_count: 1,
    },
    {
     username: "marlin_peppa", 
     avatar_url: "http://naserca.com/images/marlin_peppa.jpg",
     photo_url: "http://naserca.com/images/marlin.jpg",
     humanized_time_ago: humanized_time_ago(190),
     like_count: 0,
     comment_count: 1,   
    }
]

posts.each do |post|
    Post.create(post)
end