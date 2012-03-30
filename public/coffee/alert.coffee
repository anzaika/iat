jQuery ->
  if $.browser.opera
    $('.container-fluid').hide()
    $('#browser-alert').fadeIn()
  else
    $('#browser-alert').hide()
