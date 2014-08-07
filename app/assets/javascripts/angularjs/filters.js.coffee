@app.filter 'nfcurrency', [ '$filter', '$locale', ($filter, $locale)->
  currency = $filter('currency')
  formats = $locale.NUMBER_FORMATS
  return (amount, symbol)->
      value = currency(amount, symbol)
      return value.replace(new RegExp('\\' + formats.DECIMAL_SEP + '\\d{2}'), '')
]
