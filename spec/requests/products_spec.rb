require 'swagger_helper'

RSpec.describe 'products', type: :request do

  path '/products' do

    get('list products') do
      tags 'Product'
      description 'Get all products'
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

    post('create product') do
      tags 'Product'
      description 'Create new Product against a Store'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          code: { type: :string },
          price: { type: :string, format: :decimal },
          store_id: { type: :integer }
        },
        required: [ 'name', 'code', 'price', 'store_id' ]
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

  path '/products/{id}' do

    get('show product') do
      tags 'Product'
      description 'Get Detail of Single Product Record'
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

    put('update product') do
      tags 'Product'
      description 'Updates a Single Product Record'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :string
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          code: { type: :string },
          price: { type: :string, format: :decimal },
          store_id: { type: :integer }
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

    delete('delete product') do
      tags 'Product'
      description 'Deletes a Single Product Record'
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

  path '/products/price_check' do

    post('price check') do
      tags 'Product'
      description 'Calculates price for all the items present in cart'
      consumes 'application/json'
      parameter name: :cart, in: :body, schema: {
        type: :object,
        properties: {
          cart: {
            type: :array,
            items: {
              properties: {
                product_id: { type: :integer },
                quantity: { type: :integer }
              }
            },
          },
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

  end
end
