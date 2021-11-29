json.array! @topics do |topic|
  json.id topic.id
  json.name topic.name
  json.image_url topic.image.url
end
