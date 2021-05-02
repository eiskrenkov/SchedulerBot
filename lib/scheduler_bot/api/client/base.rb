require 'singleton'
require 'json'
require 'faraday'

class SchedulerBot::Api::Client::Base
  include Singleton

  class Error < StandardError; end

  class Response < SimpleDelegator
    alias response __getobj__

    def body_hash
      @body_hash ||= body.present? ? JSON.parse(response.body) : {}
    end

    def successful?
      (200..299).include?(response.status)
    end
  end

  def get(endpoint, params = {})
    perform_request(:get, endpoint, params)
  end

  def post(endpoint, params = {})
    perform_request(:post, endpoint, params)
  end

  private

  def api_host
    raise NotImplementedError
  end

  def api_secret
  end

  def common_params
    {}
  end

  def perform_request(verb, endpoint, params)
    params.merge!(common_params)
    sign_request(params) if api_secret

    log_request(verb, endpoint, params)

    handle_response(connection.send(verb, endpoint, params))
  rescue StandardError => e
    logger.error("API error: #{e.message}")
    raise Error, e.message
  end

  def sign_request(params)
    params.merge!(signature: SchedulerBot::Api::Signature.new(api_secret).generate(params))
  end

  def log_request(verb, endpoint, params)
    logger.info("Performing API request: #{verb.upcase} #{api_host}/#{endpoint} with params #{params.inspect}")
  end

  def handle_response(response)
    Response.new(response).tap do |response|
      logger.info("Response status is #{response.status}")
      logger.info("Response: #{response.body_hash.inspect}") if response.body.present?
    end
  end

  def handle_errrors(fallback_value)
    response = yield
    response.successful? ? response.body_hash : fallback_value
  end

  def logger
    SchedulerBot.logger
  end

  def connection
    @connection ||= Faraday.new(api_host)
  end
end
