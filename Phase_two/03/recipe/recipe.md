# sort-names Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

# Request:
POST http://localhost:9292/sort-names

# With body parameters:
names=Joe,Alice,Zoe,Julia,Kieran

# Expected response (sorted list of names):
Alice,Joe,Julia,Kieran,Zoe

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- EXAMPLE -->
<!-- Response when the query names = Joe,Alice,Zoe,Julia,Kieran -->
Alice,Joe,Julia,Kieran,Zoe

```


## 3. Write Examples

_Replace these with your own design._

```
# Request:

POST /sort-names?names=B,C,E,A,D

# Expected response: 

Response for 200 OK
Returned response.body:
B,C,E,A,D
```

```
# Request:

POST /sort-names?names=Joe,Alice,Zoe,Julia,Kieran 

# Expected response: 

Response for 200 OK
Returned response.body:
Alice,Joe,Julia,Kieran,Zoe
```

```
# Request:

GET /posts?id=276278

# Expected response:

Response for 404 Not Found
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "POST /sort-names" do
    it 'Sorts and returns letters alphabetically' do
      response = post('/sort-names?names=B,C,E,A,D')
      expect(response.status).to eq(200)
      expect(response.body).to eq('A,B,C,D,E')
    end

    it 'Sorts the example body parameters alphabetically' do
      response = post('/sort-names?names=Joe,Alice,Zoe,Julia,Kieran')
      expect(response.status).to eq(200)
      expect(response.body).to eq('Alice,Joe,Julia,Kieran,Zoe')
    end

    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')
      expect(response.status).to eq(404)
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
