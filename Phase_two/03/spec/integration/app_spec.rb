require 'spec_helper'
require 'rack/test'
require_relative '../../app.rb'

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

  context "GET to /" do
    it 'contains a h1 title' do
      response = get('/hello')
  
      expect(response.body).to include('<h1>Hello</h1>')
    end
    
    it 'contains a body' do
      response = get('/hello')
  
      expect(response.body).to include('<body>')
    end
  end
end