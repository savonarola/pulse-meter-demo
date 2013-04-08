require 'bundler'
Bundler.require

PulseMeter.redis = Redis.new

layout = PulseMeter::Visualizer.draw do |l|

  l.title "Ultra Shop Metrics"

  l.use_utc false

  l.page "Purchases" do |p|
    p.area "Purchase count" do |w|
      w.sensor :purchase_count_per_hour

      w.timespan 1.day
      w.redraw_interval 60

      w.show_last_point false
      w.values_label "Count"
      w.width 5
    end

    p.area "Purchase api requests" do |w|
      w.sensor :purchase_api_count_per_5minute

      w.timespan 1.hour
      w.redraw_interval 60

      w.show_last_point false
      w.values_label "Count"
      w.width 5
    end

    p.area "Purchase api response time" do |w|
      w.sensor :purchase_response_time_per_5minute_pecentiles

      w.timespan 1.hour
      w.redraw_interval 60

      w.show_last_point false
      w.values_label "Time, ms"
      w.width 5
    end
  end

  l.page "Requests" do |p|
    p.pie "Web requests, browsers" do |w|
      w.sensor :web_request_ff_1day
      w.sensor :web_request_chrome_1day
      w.sensor :web_request_ie_1day
      w.sensor :web_request_opera_1day
      w.sensor :web_request_mobile_1day
      w.sensor :web_request_other_1day

      w.show_last_point true
      w.values_label "Count"
      w.width 5
    end
    
    p.gauge "Unprocessed orders queue size" do |g|
      g.redraw_interval 5
      g.values_label 'Count'
      g.width 5

      g.red_from 50
      g.red_to 100
      g.minor_ticks 10

      g.sensor :queue_size
    end

    p.area "Web requests" do |w|
      w.sensor :web_request_time_1minute_percentiles
      w.timespan 1.hour
      w.redraw_interval 10

      w.show_last_point false
      w.values_label "Time, ms"
      w.width 10
    end

    p.line "Web requests" do |w|
      w.sensor :web_request_count_1minute
      w.timespan 1.hour
      w.redraw_interval 10

      w.show_last_point false
      w.values_label "Count"
      w.width 5
    end

    p.table "Web requests count per minute" do |w|
      w.sensor :web_request_count_1minute
      w.timespan 1.hour
      w.redraw_interval 10

      w.show_last_point false
      w.values_label "Count"
      w.width 5
    end

    p.table "Web requests times" do |w|
      w.sensor :web_request_time_1minute_percentiles
      w.timespan 1.hour
      w.redraw_interval 10

      w.show_last_point false
      w.values_label "Count"
      w.width 5
    end

  end
end

run layout.to_app


