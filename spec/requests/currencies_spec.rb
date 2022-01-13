require 'swagger_helper'

RSpec.describe 'currencies', type: :request do

  path '/currencies' do

    get('list currencies') do
      tags 'Currency'
      description 'Get all currencies'
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

    post('create currency') do
      tags 'Currency'
      description 'Create new Currency'
      consumes 'application/json'
      parameter name: :currency, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          code: { type: :string }
        },
        required: [ 'name', 'code' ]
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

  path '/currencies/{id}' do

    get('show currency') do
      tags 'Currency'
      description 'Get Detail of Single Currency Record'
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

    put('update currency') do
      tags 'Currency'
      description 'Update Single Currency Record'
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

    delete('delete currency') do
      tags 'Currency'
      description 'Deletes a Single Currency Record'
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
