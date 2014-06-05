unless @money_require
  json.null!
else
  json.extract! @money_require, :id, :money, :share
end
