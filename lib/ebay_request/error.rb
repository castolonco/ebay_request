# frozen_string_literal: true

class EbayRequest::Error < StandardError
  class BlankResponse < self
    attr_reader :callname, :http_status, :response_body

    def initialize(msg = nil, callname: nil, http_status: nil, response_body: nil)
      @callname = callname
      @http_status = http_status
      @response_body = response_body&.to_s&.byteslice(0, 4096)

      msg ||= "#{callname} response is blank"
      msg = "#{msg} (HTTP #{http_status})" if http_status

      super(msg)
    end
  end

  def initialize(msg = "EbayRequest error", errors: [], warnings: [])
    super(msg)
    @errors   = errors
    @warnings = warnings
  end

  # @!attribute errors   [Array<EbayRequest::ErrorItem>] fatal errors
  # @!attribute warnings [Array<EbayRequest::ErrorItem>] non-fatal errors
  attr_reader :errors, :warnings
end
