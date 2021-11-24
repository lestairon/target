json.array! @targets do |target|
  json.id target.id
  json.title target.title
  json.radius target.radius
  json.longitude target.longitude
  json.latitude target.latitude
end
