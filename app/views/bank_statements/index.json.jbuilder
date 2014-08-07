if @bank_statement.present?
  json.extract! @bank_statement, :id
  json.url @bank_statement.image_url
else
  json.null!
end
