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
    albums = repo.all

    response = albums.map do |album|
      album.title
    end
    return response.join(", ")
  end

  get '/albums/:id' do
    album_id = params[:id]
    repo = AlbumRepository.new
    album = repo.find(album_id)

    response = album.title

    return response
  end

  post '/albums' do
    repo = AlbumRepository.new
    new_album = Album.new
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]

    repo.create(new_album)

    return ""
  end

  get '/artists' do
    repo = ArtistRepository.new
    artists = repo.all

    response = artists.map do |artist|
      artist.name
    end
    return response.join(', ')
  end

  get '/artists/:id' do
    artist_id = params[:id]
    repo = ArtistRepository.new
    return repo.find(artist_id).name
  end

  post '/artists' do
    repo = ArtistRepository.new
    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]

    repo.create(artist)
    return ''
  end 
end