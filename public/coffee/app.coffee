setupAjaxCallbacks = ->
  $('body').ajaxStart( ->
    $('#ajax-status').show().text("Loading...")
  )
  $('body').ajaxStop( ->
    $("#ajax-status").fadeOut();
  )
  $('body').ajaxError( (event, xhr, ajaxOptions, thrownError) ->
    console.log("XHR Response: " + JSON.stringify(xhr))
  )

testData = {
  testComplete: false
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
  addLat: (lat) -> testData.results.latencies[testData.testInd].push(lat)
  addErr: -> this.results.errors[this.testInd]++
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

  # using $().load led to inadequately long latencies
  showNextSubTest: ->
    testData.subTestInd++
    console.log(testData.subTestParam())
    console.log(testData.testInd+" "+testData.subTestInd+" "+testData.testSequences[testData.testInd].length)
    $('#test' + testData.testInd + ' .showcase')
      .html("<img src='" + testData.subTestPath() + "'></img>")
    timer.setLast()

  showGreetings: ->
    $('#greetings').removeClass("hidden")

  showError: ->
    if $('#test' + testData.testInd + ' .alert').length
      $('#test' + testData.testInd + ' .alert').fadeIn().delay(800).fadeOut()
    else
      $('#test' + testData.testInd + ' .showcase').append("<div class='alert alert-error'>Ошибка!</div>")
      $('#test' + testData.testInd + ' .alert').delay(800).fadeOut()

}

timer = {
  last: 0
  getTime: -> (new Date()).getTime()
  setLast: -> this.last = this.getTime()
  diff: -> this.getTime()-this.last
}

eventToChar = (event) -> String.fromCharCode(event.charCode)

previousAttemptErroneous = false

jQuery ->
  setupAjaxCallbacks()
  testData.downloadTestSequences()
  timer.setLast()

  $(document).keypress( (event) ->
    time = timer.diff()
    if testData.testComplete
      return
    else if testData.subTestInd == -1
      iface.showNextSubTest()
    # Correct key for this subTest pressed
    else if eventToChar(event) == testData.subTestKey()
      previousAttemptErroneous = false
      if testData.subTestInd == (testData.testSequences[testData.testInd].length-1)
        if testData.testInd == 6
          console.log('dumping data...')
          testData.uploadTestResults()
          $('#test'+testData.testInd).addClass("hidden")
          iface.showGreetings()
          testData.testComplete = true
        # or not
        else
          testData.addLat(time)
          testData.subTestInd = -1
          console.log("Test latencies:"+testData.results.latencies[testData.testInd])
          console.log("Test errors:"+testData.results.errors[testData.testInd])
          iface.showNextTest()
      else
        testData.addLat(time)
        console.log("Latency: "+time)
        iface.showNextSubTest()
    # Wrong key for this subTest pressed
    else
      iface.showError()
      if !previousAttemptErroneous
        testData.addErr()
        previousAttemptErroneous = true
      timer.setLast()
  )
















