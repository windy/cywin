(($) ->
  $.fn.china_city = () ->
    @each ->
      filter_word = /--/
      selects = $(@).find('.city-select')
      if ! selects.first().val().match(filter_word)
        second_select = $(selects[1])
        val = second_select.attr("default")
        $.get "/china_city/#{selects.first().val()}", (data) ->
          second_select.first()[0].options.add(new Option(option[0], option[1])) for option in data
          if val
            second_select.val(val) unless val.match(filter_word)
          third_select = $(selects[2])
          val = third_select.attr("default")
          $.get "/china_city/#{second_select.val()}", (data) ->
            third_select.first()[0].options.add(new Option(option[0], option[1])) for option in data
            if val
              third_select.val(val) unless val.match(filter_word)

      selects.change ->
        $this = $(@)
        next_selects = selects.slice(selects.index(@) + 1) # empty all children city
        $("option:gt(0)", next_selects).remove()
        if next_selects.first()[0] and $this.val() and ! $this.val().match(filter_word) # init next child
          $.get "/china_city/#{$(@).val()}", (data) ->
            next_selects.first()[0].options.add(new Option(option[0], option[1])) for option in data

  $ ->
    $('.city-group').china_city()
)(jQuery)
