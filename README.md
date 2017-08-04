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