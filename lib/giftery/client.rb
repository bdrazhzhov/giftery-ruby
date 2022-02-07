# frozen_string_literal: true

require 'http'
require 'uri'
require 'json'
require 'digest'

module Giftery
  API_BASE_URL = 'https://ssl-api.giftery.ru'
  INPUT_FORMAT = 'json'
  OUTPUT_FORMAT = 'json'

  # Giftery::Client class needs to be used
  # for making requests to Giftery API
  class Client
    def initialize(client_id, secret)
      @client_id = client_id
      @secret = secret
    end

    def test
      make_request('test')
    end

    def make_order(product_id, face, options = {})
      data = options.merge!(product_id: product_id, face: face)
      make_request('makeOrder', data)
    end

    def products
      make_request('getProducts')
    end

    def certificate(queue_id)
      make_request('getCertificate', queue_id: queue_id)
    end

    def code(queue_id, order_id)
      make_request('getCode',
                   queue_id: queue_id,
                   order_id: order_id)
    end

    def links(queue_id, order_id)
      make_request('getLinks',
                   queue_id: queue_id,
                   order_id: order_id)
    end

    def status(id)
      make_request('getStatus', id: id)
    end

    def categories
      make_request('getCategories')
    end

    def balance
      make_request('getBalance')
    end

    def address(product_id, area_name, locality_name)
      make_request('getBalance',
                   product_id: product_id,
                   area_name: area_name,
                   locality_name: locality_name)
    end

    private

    def signature(method_name, data)
      Digest::SHA256.hexdigest "#{method_name}#{data}#{@secret}"
    end

    def params(method_name, data)
      data_json = data ? JSON.generate(data) : ''
      {
        id: @client_id,
        cmd: method_name,
        data: data_json,
        sig: signature(method_name, data_json),
        in: INPUT_FORMAT,
        out: OUTPUT_FORMAT
      }
    end

    def make_request(method_name, data = nil)
      response = HTTP.get("#{API_BASE_URL}/?#{URI.encode_www_form(params(method_name, data))}")
      result = JSON.parse(response.to_s)
      raise result['error']['text'] unless result['status'] == 'ok'

      result['data']
    end
  end
end
