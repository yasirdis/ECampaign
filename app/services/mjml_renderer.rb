# app/services/mjml_renderer.rb
require "mrml"

class MjmlRenderer
  def self.to_html(mjml)
    MRML.to_html(mjml)
  rescue => e
    "<pre>MJML Error: #{e.message}</pre>"
  end
end
