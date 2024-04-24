Rack::Attack.throttle("requests by ip", limit: 5, period: 2) do |request|
  request.ip
end

# Throttle query for companies filter to 10 reqs/sec
Rack::Attack.throttle('limit query for companies filter', limit: 10, period: 1) do |request|
  if request.path == '/companies' && request.get?
    request.ip
  end
end
