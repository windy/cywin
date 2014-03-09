def check_json(json_str, key, expected)
  unless json_str.kind_of?(JSON)
    json_str = JSON.parse(json_str)
  end
  
  result = json_str[key.to_sym] || json_str[key.to_s]
  expect(result).to be(expected)
end
