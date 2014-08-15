json.array! @heads do |head|
  json.k do
    json.extract! head, :id, :name, :description
  end
  json.v do
    json.array! head.categories do |category|
      json.extract! category, :id, :name
    end
  end
end
