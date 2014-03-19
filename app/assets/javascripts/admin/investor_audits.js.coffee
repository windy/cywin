$(document).ready ->
  $('.investor_passed').click (e)->
    e.preventDefault()
    if confirm_data = $(this).data('confirm')
      return unless window.confirm( confirm_data )
      
    $.post $(this).data('uri'), (data)=>
      Alert.doit data, =>
        $(this).parents('tr').hide()

  $('.investor_rejected').click (e)->
    e.preventDefault()
    if prompt_data = $(this).data('prompt')
      return unless note = window.prompt(prompt_data)
    $.post $(this).data('uri'), { note: note }, (data)=>
      Alert.doit data, =>
        $(this).parents('tr').hide()
