class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :get_client

  def get_client
    @hoopla_client = HooplaClient.hoopla_client
    $descriptor = @hoopla_client.get('/', {'Accept' => 'application/vnd.hoopla.api-descriptor+json'})
  end

  def get_metrics
    @metric_list = @hoopla_client.get('/metrics', {'Accept' => 'application/vnd.hoopla.metric-list+json'})
  end

  def get_metric_by_href(href)
    @metric_value_list = @hoopla_client.get(href, {'Accept' => 'application/vnd.hoopla.metric-value-list+json'})
  end

  def update_metric(href, metric)
    @metric_update = @hoopla_client.post(href, {'Accept' => 'application/vnd.hoopla.metric-value+json'}, metric.to_json)
  end
end
