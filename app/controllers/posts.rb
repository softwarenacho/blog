enable :sessions

get '/new' do
  erb :new_post
end

post '/save_post' do
  @id = session[:id]
  @title = params[:title]
  @content = params[:content]
  @tags = params[:tags]
  puts "ID #{@id} TITLE #{@title} CONTENT #{@content}"
  post = Post.new(users_id: @id, title: @title, content: @content)
  post.save!
  p @tags
  splitted_tags = @tags.gsub(/[[:space:]]/,'').split("\#")
  puts splitted_tags.to_s
  splitted_tags.each do |tag|
    # Tag.find_or_create_by(tag: tag)

    check = Tag.find_by(tag: tag)
    puts "CHECK #{check}"
    p check
    puts "TAG #{tag}"
    if check == nil
      tag = Tag.new(tag: tag)
      tag.save!
      PostsTags.create(posts_id: post.id, tags_id: tag.id)
    else
      PostsTags.create(posts_id: post.id, tags_id: check.id)
    end
  end
  redirect to('/home')
end

get '/post/:id_post' do
  id = params[:id_post]
  post = Post.find(id)
  puts "ID del post#{id} post: #{post}"
  @title = post.title
  @content = post.content
  @date = post.created_at
  user = User.find(post.users_id)
  @name = user.name
  @tags_finded = PostsTags.where("posts_id = ?", post.id)
  @tags = ""
  @tags_finded.each do |posttag|
    tag_id = posttag.tags_id
    puts "#{tag_id}"
    tag = Tag.find(tag_id)
    puts "#{tag.tag}"
    @tags.concat("\##{tag.tag} ")
  end
  erb :post
end

get '/delete/:id_post' do
  id = params[:id_post]
  post = Post.find(id)
  post.destroy
  redirect to('/home')
end

get '/edit/:id_post' do
  @id = params[:id_post]
  post = Post.find(@id)
  puts "ID del post#{@id} post: #{post}"
  @title = post.title
  @content = post.content
  @tags = PostsTags.where("posts_id = ?", @id)
  puts @tags.to_s
  @tags.each do |t|
    t.destroy
  end
  erb :edit_post
end

post '/update_post/:post_id' do
  @post_id = params[:post_id]
  post = Post.find(@post_id)
  @title = params[:title]
  @content = params[:content]
  @tags = params[:tags]
  puts "id #{@post_id} title #{@title} content #{@content}"
  Post.update(@post_id, :title => @title, :content => @content)
  #tags section
  splitted_tags = @tags.gsub(/[[:space:]]/,'').split("\#")
  puts splitted_tags.to_s
  splitted_tags.each do |tag|
    check = Tag.find_by(tag: tag)
    puts "CHECK #{check}"
    p check
    puts "TAG #{tag}"
    if check == nil
      tag = Tag.new(tag: tag)
      tag.save!
      PostsTags.create(posts_id: post.id, tags_id: tag.id)
    else
      PostsTags.create(posts_id: post.id, tags_id: check.id)
    end
  end
  redirect to('/home')
end

post '/search_tags' do
  @tag = params[:tag]
  tag_id = Tag.find_by(tag: @tag).id
  puts "ENTRE A TAGS"
  puts "TAG #{@tag} ID #{tag_id}"
  posttags = PostsTags.where("tags_id = ?", tag_id)
  @posts = []
  posttags.each do |pt|
    post_id = pt.posts_id
    @posts << Post.find(post_id)
  end
  erb :search
end