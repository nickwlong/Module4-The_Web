require "spec_helper"
require "rack/test"
require_relative '../../app'


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
  end

  context "GET /albums" do
    it 'returns lists of albums' do
      # Assuming the post with id 1 exists.
      response = get('/albums')

      expected_response = "Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring"

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end



    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end

  context "GET /albums/:id" do
    it 'returns a specific album title from id=1' do
      response = get('/albums/1')

      expected_response = "Doolittle"

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
    
    it 'returns a specific album title from id=4' do
      response = get('/albums/4')

      expected_response = "Super Trouper"

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context "POST /albums" do
    it 'adds album to database' do
      response = post('/albums', title: 'OK Computer', release_year: '1997', artist_id: '1')

      expect(response.status).to eq(200)
      expect(response.body).to eq ""
      repo = AlbumRepository.new
      
      response2 = get('/albums')

      expect(response2.body).to include "OK Computer"
    end
  end

end

