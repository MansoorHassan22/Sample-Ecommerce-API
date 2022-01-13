require 'swagger_helper'

RSpec.describe 'discounts', type: :request do

  path '/discounts' do

    get('list discounts') do
      tags 'Discount'
      description 'Get all Discounts'
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

    post('create discount') do
      tags 'Discount'
      description 'Create new Discount'
      consumes 'application/json'
      parameter name: :discount, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          is_percentage_type: { type: :boolean },
          is_product_type: { type: :boolean },
          minimum_products: { type: :integer },
          maximum_products: { type: :integer },
          free_products: { type: :integer },
          percentage: { type: :integer },
          product_ids: {
            type: :array,
            items: [],
          },
        },
        required: [ 'name', 'minimum_products' ]
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

  path '/discounts/{id}' do

    get('show discount') do
      tags 'Discount'
      description 'et Detail of Single Discount Record'
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

    put('update discount') do
      tags 'Discount'
      description 'Updates a Single Discount Record'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :string
      parameter name: :discount, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          is_percentage_type: { type: :boolean },
          is_product_type: { type: :boolean },
          minimum_products: { type: :integer },
          maximum_products: { type: :integer },
          free_products: { type: :integer },
          percentage: { type: :integer }
        },
        required: [ 'name', 'minimum_products' ]
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

    
    delete('delete discount') do
      tags 'Discount'
      description 'Deletes a Single Discount Record'
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

  path '/discounts/{id}/add_products' do

    post('add products to discounts') do
      tags 'Discount'
      description 'Add products against a discount'
      consumes 'application/json'
      parameter name: 'id', in: :path, type: :string
      parameter name: :discount, in: :body, schema: {
        type: :object,
        properties: {
          product_ids: {
            type: :array,
            items: [],
          },
        },
        required: [ 'name', 'minimum_products' ]
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


