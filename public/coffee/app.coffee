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

testData = {
  results: {
    latencies: [[],[],[],[],[],[],[]]
    errors: [0,0,0,0,0,0,0]
  }
  testSequences: []
  testInd: 0
  subTestInd: -1
  subTestParam: -> this.testSequences[this.testInd][this.subTestInd]
  subTestPath: -> "/images/"+this.subTestParam()[0]+"/"+this.subTestParam()[1]+".jpg"
  subTestKey: -> this.subTestParam()[2]
  add_lat: (lat) -> testData.results.latencies[testData.testInd].push(lat)
  add_err: -> this.results.errors[this.testInd]++
  downloadTestSequences: ->
    $.get("/testSequences.json", (data) -> testData.testSequences = JSON.parse(data) )
  uploadTestResults: ->
    $.ajax({
      type: "POST",
      url: "/testResults.json",
      contentType: "application/json",
      data: JSON.stringify(testData.results),
      success: -> console.log("Successful run of postResult!")
    })
}

iface = {
  showNextTest: ->
    $('#test'+(testData.testInd++)).addClass("hidden")
    $('#test'+testData.testInd).removeClass("hidden")

  showNextSubTest: ->
    testData.subTestInd++
    console.log(testData.subTestParam())
    console.log(testData.testInd+" "+testData.subTestInd+" "+testData.testSequences[testData.testInd].length)
    $('#test' + testData.testInd + ' .showcase').html("<img src='" + testData.subTestPath() + "'></img>")

  showGreetings: ->

  showError: ->
    if $('#test' + testData.testInd + ' .alert').length
      $('#test' + testData.testInd + ' .alert').fadeIn().delay(800).fadeOut()
    else
      $('#test' + testData.testInd + ' .showcase').append("<div class='alert alert-error'>Ошибка!</div>")
      $('#test' + testData.testInd + ' .alert').delay(800).fadeOut()

}

timer = {
  last: 0
  gettime: -> (new Date()).getTime()
  set_last: -> this.last = this.gettime()
  diff: -> this.gettime()-this.last
}

eventToChar = (event) -> String.fromCharCode(event.charCode)

jQuery ->
  setupAjaxCallbacks()
  testData.downloadTestSequences()

  $(document).keypress( (event) ->
    if testData.subTestInd == -1
      iface.showNextSubTest()
      timer.set_last()
    else if testData.subTestInd == (testData.testSequences[testData.testInd].length-1)
      if testData.testInd == 6
        console.log('dumping data...')
        testData.uploadTestResults()
        iface.showGreetings()
      else
        testData.add_lat(timer.diff())
        testData.subTestInd = -1
        iface.showNextTest()
    else if eventToChar(event) == testData.subTestKey()
      testData.add_lat(timer.diff())
      iface.showNextSubTest()
    else
      iface.showError()
      timer.set_last()
  )
















