require 'bundler'
Bundler.require

PulseMeter.redis = Redis.new

sensors = PulseMeter::Sensor::Configuration.new(
  purchase_count_per_hour: {
    sensor_type: 'timelined/counter',
    args: {
      interval: 1.hour,
      ttl: 1.month,
      annotation: 'Purchases'
    }
  },

  purchase_api_count_per_5minute: {
    sensor_type: 'timelined/counter',
    args: {
      interval: 5.minutes,
      ttl: 1.week,
      annotation: 'Purchase api calls'
    }
  },

  purchase_response_time_per_5minute_pecentiles: {
    sensor_type: 'timelined/multi_percentile',
    args: {
      interval: 5.minutes,
      ttl: 1.week,
      p: [0.9, 0.95, 0.99],
      annotation: 'Purchase api calls'
    }
  },

  web_request_count_1minute: {
    sensor_type: 'timelined/counter',
    args: {
      interval: 1.minute,
      ttl: 1.week,
      annotation: 'Web requests'
    }
  },

  web_request_time_1minute_percentiles: {
    sensor_type: 'timelined/multi_percentile',
    args: {
      interval: 1.minute,
      ttl: 1.week,
      p: [0.9, 0.95, 0.99],
      annotation: 'Web request time'
    }
  },

  web_request_ff_1day: {
    sensor_type: 'timelined/uniq_counter',
    args: {interval: 1.day, ttl: 1.month, annotation: 'Firefox'}
  },
  web_request_chrome_1day: {
    sensor_type: 'timelined/uniq_counter',
    args: {interval: 1.day, ttl: 1.month, annotation: 'Chrome'}
  },
  web_request_ie_1day: {
    sensor_type: 'timelined/uniq_counter',
    args: {interval: 1.day, ttl: 1.month, annotation: 'IE'}
  },
  web_request_opera_1day: {
    sensor_type: 'timelined/uniq_counter',
    args: {interval: 1.day, ttl: 1.month, annotation: 'Opera'}
  },
  web_request_mobile_1day: {
    sensor_type: 'timelined/uniq_counter',
    args: {interval: 1.day, ttl: 1.month, annotation: 'Mobile'}
  },
  web_request_other_1day: {
    sensor_type: 'timelined/uniq_counter',
    args: {interval: 1.day, ttl: 1.month, annotation: 'Other'}
  }

)

browsers = [
  :web_request_ff_1day,
  :web_request_chrome_1day,
  :web_request_ie_1day,
  :web_request_opera_1day,
  :web_request_mobile_1day,
  :web_request_other_1day
]

while true
  sleep(Random.rand)
  puts 'tick'

  browser = browsers.sample
  sensors.sensor(browser){|s| s.event(Random.rand.to_s) }
  if Random.rand(10) == 0
     sensors.purchase_count_per_hour(1)
     sensors.purchase_api_count_per_5minute(1)
     sensors.purchase_response_time_per_5minute_pecentiles(Random.rand)
  end

  sensors.web_request_time_1minute_percentiles(Random.rand * 10)
  sensors.web_request_count_1minute(1)
end





