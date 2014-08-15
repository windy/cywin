json.success true
json.data do
  json.extract! @law_iterm, :id, :title, :description, :public
end
