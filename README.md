# Sinatra App 만들기

## I. 시작하기
### 1. C9 Set up
먼저 필요한 Gem들을 깔아줍니다.
```
gem install sinatra thin
```

### 2. Instant Gratification
`app.rb` 파일을 만들어주고, 아래와 같은 내용을 담아줍니다.
```ruby
require 'sinatra'

get '/' do
  "Hack your life!"
end
```

### 3. Running the project
C9 환경변수에 저장된 PORT와 IP를 활용하여 프로젝트를 시작해줍니다.
```
ruby app.rb -o $IP -p $PORT
```
자신의 프로젝트는 
`https://[프로젝트이름]-[자신의 c9 아이디].c9users.io` 에서 확인하실 수 있습니다.

---
## II. Simple CRUD
### 1. 데이터 베이스와 ORM 활용하기
Database는 SQLite3, ORM은 DataMapper를 활용합니다.
일단 뭔지 모르겠지만, 깔아주고 시작합시다.
SQLite3는 이미 우리 workspace에 깔려 있고,
우리가 필요한 건 data_mapper(& 어댑터) !
```
gem install data_mapper dm-sqlite-adapter
```

깔긴 깔았는데 이건 뭐지????
일단 모를 때는 Google로 `sinatra datamapper`를 검색해봅니다.
[http://recipes.sinatrarb.com/p/models/data_mapper](http://recipes.sinatrarb.com/p/models/data_mapper)
이런 검색 결과가 나오면, 들어가서 봅니다.

일단 모를 때는 통째로 복사해 봅니다.
복붙 후에 `app.rb`는 다음과 같을 거에요.
```ruby
require 'sinatra'
require 'data_mapper'
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!

get '/' do
  "Hack your life!"
end
```
정확히는 모르겠지만 이런 것 같네요
1. DataMapper로 뭔가 셋업을 하는 거구나(sqlite 파일을 만드는 듯)
2. Post라는 친구를 만드네. (`id, title, body, created_at`이라는 게 들어가는 듯)
3. 뭔가 마무리짓네 `.finalize! == .마무리하기!`
4. 뭔가 자동으로 업글하네 `.auto_upgrade! == .업글!`

감만 잡으면 됩니다.

### 2. view를 떼어내기 & 입력폼 만들기
일단 메인(인덱스/루트) 페이지를 떼어냅시다.
`views`라는 폴더를 만들어내고 파일명을 `index.erb`로 할게요.
그럼 `/views/index.erb` 파일 안에는 간단한 게시글 입력폼을 넣어보겠습니다.

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Likelion</title>
    <meta charset='utf-8'>
  </head>
  <body>
    <h1>게시판 테스트</h1>
    <form action="/create_post">
      제목 : <input type="text" name="title">
      내용 : <input type="text" name="content">
      <button type="submit">글쓰기</button>
    </form>
  </body>
</html>
```
초단간 입력폼을 만들구요
1. 이 내용을 `/create_post`로 넘겨줄겁니다.
2. 제목은 `title`이라는 이름을 붙여주고
3. 내용은 `content`라는 이름을 붙여줬어요.

그리고 `app.rb`의 코드를 바꿔줍니다.
```ruby
get '/' do
  "Hack your life"
end
```
원래 `"Hack your life"` 걍 글자 그대로 보내주던걸, `erb :index`로 보내줍니다.
```ruby
get '/' do
  erb :index
end
```

날려줬으니 받아줘야 겠죠?

### 3. create_post 만들기
일단 `create_post`라는 새로운 라우터를 하나 만들어주고, view도 설정해줍니다.
```ruby
get '/create_post' do
  erb :create_post
end
```
그리고 index page에서 날려준 데이터 두 개를 일단 받아서 보여줘 볼게요.
```ruby
get '/create_post' do
  @title = params[:title] 
  @content = params[:content]
  # title, content를 받아서 @title, @content에 저장 !
  erb :create_post
end
```

당연히 `views/create_post.erb` 도 만들어줘야겠죠?
```html
<!DOCTYPE html>
<html>
  <head>
    <title>Likelion</title>
    <meta charset='utf-8'>
  </head>
  <body>
    <h1>게시판 테스트</h1>
    제목 : <p><%= @title %></p>
    내용 : <p><%= @content %></p>
    <a href="/">홈으로</a>
  </body>
</html>
```

파일 안에는 간단히 날아온 데이터를 받아서 보여줘 봅니다.
루비코드이기 때문에, `<%= %>`를 둘어주셔야 하는 거 잊지 마시구영.

저장 후에 서버를 돌리시고 확인해보세요 !
