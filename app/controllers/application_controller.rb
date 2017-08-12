class ApplicationController < ActionController::API
  include Knock::Authenticable
  before_action :default_format

  def default_format
    request.format = 'json'
  end
end
