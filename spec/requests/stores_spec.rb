require 'swagger_helper'

RSpec.describe 'stores', type: :request do

  path '/stores' do

    get('list stores') do
      tags 'Store'
      description 'Get all stores'
      consumes 'application/json'
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create store') do
      tags 'Store'
      description 'Create new Store'
      consumes 'application/json'
      parameter name: :store, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          currency_id: { type: :integer }
        },
        required: [ 'name', 'currency_id' ]
      }
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/stores/{id}' do

    get('show store') do
      tags 'Store'
      description 'Get Detail of Single Store Record'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :string
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update store') do
      tags 'Store'
      description 'Updates a Single Store Record'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :string
      parameter name: :store, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          currency_id: { type: :integer }
        }
      }
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete store') do
      tags 'Store'
      description 'Deletes a Single Store Record'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :string
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
