json.array! @targets do |target|
  json.partial! target, as: :target
end
