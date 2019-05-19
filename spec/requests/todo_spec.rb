require 'rails_helper'

RSpec.describe 'TODO Api', type: :request do
  #Initialize test data
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  #Test suite for GET /todos
  describe 'GET /todos' do
    #Make Http Request before each example
    before { get '/todos' }
    it 'returns todos' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end
    #Test suite for GET /todos/:id
  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}" }

    context 'when the record id exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record id doesnt exists' do
      let(:todo_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(JSON.parse(response.body)).to match("message" => "Couldn't find Todo with 'id'=#{todo_id}")
      end
    end
  end

  #Test suite for POST /todo
  describe 'POST /todo' do
    #Valid payload
    let(:valid_attributes) { { title: 'Test Title', created_by: 1 } }

    context 'when the request is valid' do
      before { post '/todos', params: valid_attributes }

      it 'include location in header' do
        expect(response.headers['location']).not_to be_empty
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/todos', params: { title: 'Invalid Object' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(JSON.parse(response.body)).to match("message" => "Validation failed: Created by can't be blank")
      end
    end
  end

  #Test suite for PUT /todo/:id
  describe 'PUT /todo/:id' do
    let(:valid_attributes) { { title: 'Valid Title For Put Method' } }

    context 'when the record exists' do
      before { put "/todos/#{todo_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  #Test suite FOR DELETE /todo/:id
  describe 'DELETE /todo/:id' do
    before { delete "/todos/#{todo_id}" }
    it 'deletes the record ' do
      expect(response.body).to be_empty
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
