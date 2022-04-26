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
  # for making requests to Giftery API https://docs.giftery.tech/b2b-api/
  class Client
    def initialize(client_id, secret)
      @client_id = client_id
      @secret = secret
    end

    def test
      make_request('test')
    end

    # Creates order
    # More info here: https://docs.giftery.tech/b2b-api/methods/makeOrder/
    def make_order(product_id, face, options = {})
      data = options.merge!(product_id: product_id, face: face)
      make_request('makeOrder', data)
    end

    # Returns list of available products
    # More info here: https://docs.giftery.tech/b2b-api/methods/getProducts/
    def products
      make_request('getProducts')
    end

    # Returns base64 encoded PDF certificate
    # More info here: https://docs.giftery.tech/b2b-api/methods/getCertificate/
    def certificate(queue_id)
      make_request('getCertificate', queue_id: queue_id)
    end

    # Returns certificate requisites
    # More info here: https://docs.giftery.tech/b2b-api/methods/getCode/
    def code(queue_id, order_id)
      make_request('getCode',
                   queue_id: queue_id,
                   order_id: order_id)
    end

    # Returns certificate links
    # More info here: https://docs.giftery.tech/b2b-api/methods/getLinks/
    def links(queue_id, order_id)
      make_request('getLinks',
                   queue_id: queue_id,
                   order_id: order_id)
    end

    # Returns status of order that is created by make_order
    # More info here: https://docs.giftery.tech/b2b-api/methods/getStatus/
    def status(id)
      make_request('getStatus', id: id)
    end

    # Returns list of available certificate categories
    # More info here: https://docs.giftery.tech/b2b-api/methods/getCategories/
    def categories
      make_request('getCategories')
    end

    # Returns your available balance
    # More info here: https://docs.giftery.tech/b2b-api/methods/getBalance/
    def balance
      make_request('getBalance')
    end

    # Returns list of places (with address) where certificate can be accepted
    # More info here: https://docs.giftery.tech/b2b-api/methods/getAddress/
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
