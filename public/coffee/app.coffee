setupAjaxCallbacks = ->
  #  $('body').ajaxStart( ->
  #  $('#ajax-status').show().text("Loading...")
  #)
  #$('body').ajaxStop( ->
  #  $("#ajax-status").fadeOut();
  #)
  $('body').ajaxError( (event, xhr, ajaxOptions, thrownError) ->
    console.log("XHR Response: " + JSON.stringify(xhr))
  )

updatePicAndTimer = ->
  $('#place').load("/next")
  $(document).ready(->
    timer.set_last()
  )


testResults = {
  reactionLatencies: []
  errors: 0
}

testProgress = {
  test: 1
  subTest:1
}

uploadTestResults = ->
  $.ajax({
    type: "POST",
    url: "/results.json",
    contentType: "application/json",
    data: JSON.stringify(testResults),
    success: -> console.log("Successful run of postResult!")
  })

timer = {
  gettime: -> (new Date()).getTime()
  set_last: -> this.last = this.gettime()
  diff: -> this.gettime()-this.last
}

eventToChar   = (event) -> String.fromCharCode(event.charCode)
showcase_klass = (klass) -> $('#showcase').hasClass(klass)

jQuery ->
  setupAjaxCallbacks()

  $(document).keypress( (event) ->
    if showcase_klass('init')
      updatePicAndTimer()
    else
      if $("#tt").hasClass(testProgress.subTest)
        testResults.reactionLatencies.push(timer.diff())
        uploadTestResults()
        updatePicAndTimer()
      else
        if showcase_klass(eventToChar(event))
          testProgress.subTest++
          testResults.reactionLatencies.push(timer.diff())
          updatePicAndTimer()
        else
          test.errors++
          $('#showcase').append('<div class="alert alert-error">Неправильно</div>')
          timer.set_last()
  )
