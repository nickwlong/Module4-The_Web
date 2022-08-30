# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

    # Request:
    POST /artists

    # With body parameters:
    name=Wild nothing
    genre=Indie

    # Expected response (200 OK)
    (No content)

    # Then subsequent request:
    GET /artists

    # Expected response (200 OK)
    Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- EXAMPLE -->
<!-- POST request to /artists-->

    # With body parameters:
    name=Wild nothing
    genre=Indie

    # Expected response (200 OK)
    (No content)

<!-- GET request /artists should include Wild nothing-->

Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing

```

## 3. Write Examples

_Replace these with your own design._

```
# Request:

POST /artists

# Expected response:

Response for 200 OK
No return
```

```

# Request:

POST /artists

# Expected response:

Response for 200 OK
No return

THEN

GET /artists

# Expected response:

Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing


```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "POST /artists" do
    it 'updates artists table with a new artist' do
      response = post('/artists', :name='Wild nothing', :genre='Indie')

      expect(response.status).to eq(200)

      response2 = get('/artists')

      expect(response.body).to include ('Wild nothing')
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->