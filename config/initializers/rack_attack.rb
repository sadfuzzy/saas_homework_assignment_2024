Rack::Attack.throttle('requests by ip', limit: 5, period: 1, &:ip)

# Throttle query for companies filter
Rack::Attack.throttle('limit query for companies filter', limit: 4, period: 1) do |request|
  request.ip if request.path == '/companies' && request.get?
end
