require "spec_helper"
require "rack/test"
require_relative '../../app'



def reset_albums_table
  seed_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

def reset_artists_table
  seed_sql = File.read('spec/seeds/artists_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end


describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do 
    reset_albums_table
    reset_artists_table
  end

  context "GET /albums" do
    it 'returns lists of albums' do
      # Assuming the post with id 1 exists.
      response = get('/albums')

      expect(response.status).to eq(200)
      expect(response.body).to include '<h1>Albums</h1>'
      expect(response.body).to include "<a href='albums/1' >Doolittle</a>"
      expect(response.body).to include 'Release year: 1989'

      expect(response.body).to include "<a href='albums/3' >Waterloo</a>"
      expect(response.body).to include 'Release year: 1974'

    end



    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end

  context "GET /albums/:id" do
    it 'returns info regarding album 1' do
      response = get('/albums/1')

      expected_response = "Doolittle"

      expect(response.status).to eq(200)
      expect(response.body).to include "Doolittle"
      expect(response.body).to include "Release year: 1989"
      expect(response.body).to include "Artist: Pixies"
    end
    
    # it 'returns a specific album title from id=4' do
    #   response = get('/albums/4')

    #   expected_response = "Super Trouper"

    #   expect(response.status).to eq(200)
    #   expect(response.body).to eq(expected_response)
    # end
  end

  context "GET /artists" do
    # Add a route GET /artists which returns an HTML page with the list of artists. 
    it 'returns HTML page with a list of artists, each artist is linked to artist page' do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to include "<a href='artists/1' >Pixies</a>"
      expect(response.body).to include "<a href='artists/2' >ABBA</a>"
    end
  end

  context "GET /artists/:id" do

    # Add a route GET /artists/:id which returns an HTML page showing details for a single artist.
    it 'returns HTML page showing details for artist with id = 1' do
      response = get('/artists/1')


      expect(response.status).to eq(200)
      expect(response.body).to include "<h1>Artist's Name: Pixies</h1>"
      expect(response.body).to include "<p>The genre of Pixies is Rock.</p>"
      
    end
    it 'returns HTML page showing details for artist with id = 2' do
      response = get('/artists/2')


      expect(response.status).to eq(200)
      expect(response.body).to include "<h1>Artist's Name: ABBA</h1>"
      expect(response.body).to include "<p>The genre of ABBA is Pop.</p>"
    end
  end

  # context "POST /artists" do
  #   it 'updates artists table with a new artist' do
  #     response = post('/artists', name: 'Wild nothing', genre: 'Indie')

  #     expect(response.status).to eq(200)
  #     expect(response.body).to eq ''
  #     response = get('/artists')

  #     expect(response.body).to eq ('Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing')

  #   end
  # end
  context "GET /albums/new" do
    it 'returns the form page' do
      response = get('/albums/new')

      expect(response.status).to eq (200)
      expect(response.body).to include ('<h1>Add an album:</h1>')

      expect(response.body).to include ('<form action="/albums" method = "POST">')
      expect(response.body).to include ('<input type="text" name="title">')
      
    end
  end

  context "POST /albums" do
    it 'Returns a success page' do
      response = post(
        '/albums',
        title: 'Test Album',
        release_year: '2022',
        artist: 'Test Artist'
      )
      
      expect(response.status).to eq (200)
      expect(response.body).to include ('<p>Your album \'Test Album\' has been added!</p>')

    end
    it 'Returns a success page' do
      response = post(
        '/albums',
        title: 'Another test',
        release_year: '2022',
        artist: 'Test Artist'
      )
      
      expect(response.status).to eq (200)
      expect(response.body).to include ('<p>Your album \'Another test\' has been added!</p>')
    end
    it 'Has added album to database' do
      response = post(
        '/albums',
        title: 'Another test',
        release_year: '2022',
        artist: 'Test Artist'
      )
      expect(response.status).to eq 200

      response = get('/albums')
      expect(response.body).to include "<a href='albums/13' >Another test</a>"
    end
  end

  context 'POST /artists' do
    it 'Returns a success page' do
      response = post(
        '/artists',
        name: 'Testartist',
        genre: 'Rock'
      )
      
      expect(response.status).to eq (200)
      expect(response.body).to include ('<h1>Your artist \'Testartist\' has been added!</h1>')

    end
    it 'Returns a success page' do
      response = post(
        '/artists',
        name: 'Los Campesinos',
        genre: 'Alternative'
      )
      
      expect(response.status).to eq (200)
      expect(response.body).to include ('<h1>Your artist \'Los Campesinos\' has been added!</h1>')
    end
  end
end
