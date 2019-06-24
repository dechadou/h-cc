class HomeController < ApplicationController

  def index
    $metric_list = get_metrics
  end

  def show
    $metric_value_list = get_metric_by_href(params[:href])


    $metric_name = params[:name]

    $data = Array.new
    $metric = Array.new
    $metric_value_list.each do |element|
      if(element["owner"]["kind"] == "user")
        $metric.push Metric.new(element)
      end
    end

  end

  def edit
    $metric = JSON.parse(params[:metric])
  end

  def update
    $new_value = params[:value]
    $parent_metric = params[:parent_metric_href]
    $metric_href = params[:metric_href]
    $metric_owner_kind = params[:metric_owner_kind]
    $metric_owner_href = params[:metric_owner_href]

    $metric = [:metric => $metric_href, :owner => [:kind => $metric_owner_kind, :href => $metric_owner_href], :value => $new_value]

    #TODO: This does not work properly.
    #$metric_update = update_metric($metric_href, $metric)

    redirect_to :controller => 'home', :action => 'show', href: $parent_metric+'/values'
  end
end
