if @card.present?
  json.extract! @card, :id
  json.url @card.image_url
else
  json.null!
end
