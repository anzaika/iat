jQuery(
  $(document).keypress( (event) ->
    if event.charCode == 101 or event.charCode == 105
      $('#place').load("/next")
    else
      alert('bad boy')
  )
)
