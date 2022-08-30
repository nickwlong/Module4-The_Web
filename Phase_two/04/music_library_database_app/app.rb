# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:albums)
  end

  get '/albums/new' do
    return erb(:albums_new)
  end

  get '/albums/:id' do
    artist_repo = ArtistRepository.new
    repo = AlbumRepository.new
    @album = repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
  end

  post '/albums' do
    @album_name = params[:title]

    album = Album.new
    album.title = params[:title]
    album.release_year = params[:release_year]
    album.artist_id = params[:artist_id]
 
    album_repo = AlbumRepository.new
    album_repo.create(album)
    return erb(:albums_new_created)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:artists)
  end

  get '/artists/new' do
    return erb(:artists_new)
  end

  get '/artists/:id' do
    artist_id = params[:id]
    repo = ArtistRepository.new
    @artist = repo.find(artist_id)

    return erb(:artist)
  end

  post '/artists' do
    @artist_name = params[:name]

    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]

    artist_repo = ArtistRepository.new
    artist_repo.create(artist)

    return erb(:artists_new_created)
  end 

end