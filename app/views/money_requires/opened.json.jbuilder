json.money_require do
  unless @money_require
    json.nil!
  else
    json.partial! 'money_require'
  end
end
