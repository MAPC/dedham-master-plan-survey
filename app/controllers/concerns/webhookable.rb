module Webhookable
extend ActiveSupport::Concern
  def render_twiml(response, status: :ok)
    render plain: response.to_s, content_type: 'text/xml', status: status
  end

  def twiml_response(text)
    Twilio::TwiML::MessagingResponse.new do |r|
      r.message(body: text)
    end
  end
end
