

JQuery = ->

  setupAjaxCallbacks = ->
    $('body').ajaxStart -> $('#ajax-status').show().text("Loading...")
    $('body').ajaxStop -> $('#ajax-status').fadeOut()
