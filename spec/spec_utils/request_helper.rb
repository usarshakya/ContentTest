module RequestHelper
  def send_get_request(route, params = {}, headers = auth_headers)
    get route, headers:, params:
  end

  def send_post_request(route, params, headers = auth_headers)
    post route, headers:, params:
  end

  def send_put_request(route, params, headers = auth_headers)
    patch route, headers:, params: params.to_json
  end

  def send_delete_request(route, params = {}, headers = auth_headers)
    delete route, headers:, params:
  end
end
