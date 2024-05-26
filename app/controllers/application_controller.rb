class ApplicationController < ActionController::API
  include ExceptionHandler
  before_action :underscore_params!

  private

  def underscore_params!
    params.deep_transform_keys!(&:underscore)
  end
end