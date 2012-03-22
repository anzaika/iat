jQuery(
  $(document).keypress( (event) ->
    if event.charCode == 101 or
       event.charCode == 105 or
       event.charCode == 1096 or
       event.charCode == 1091
      $('#place').load("/next")
  )
)
