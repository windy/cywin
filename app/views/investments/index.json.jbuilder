json.array! @investments do |investment|
  json.partial! 'investment', investment: investment
end
