jQuery(
  d = new Date()
  to_chr = (event) -> String.fromCharCode(event.charCode)
  $(document).keypress( (event) ->
    if $('#showcase').hasClass('init') or
       $('#showcase').hasClass(to_chr(event))
      $('#place').load("/next")
    else
      $('#showcase').append('<div class="alert alert-error">Неправильно</div>')
  )
)
