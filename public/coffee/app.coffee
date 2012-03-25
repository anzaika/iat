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
  subTestParam: -> this.testSequnces[this.testInd][this.subTestInd]
  subTestPath: -> "/image/"+this.subTestParam()[0]+"/"+this.subTestParam()[1]+".jpg"
  subTestKey: -> this.subTestParam()[2]
  downloadTestSequences: ->
    $.get("/testSequences.json", (data) -> this.testSequnces = data)
  uploadTestResults: ->
    $.ajax({
      type: "POST",
      url: "/testResults.json",
      contentType: "application/json",
      data: JSON.stringify(this.results),
      success: -> console.log("Successful run of postResult!")
    })
}

iface = {
  showNextTest: ->
    $('#test'+(testData.testInd++)).addClass("hidden")
    $('#test'+testData.testInd).deleteClass("hidden")

  showNextSubTest: ->
    testData.subTestInd++
    $('#test'+testData.testInd+' .showcase').html("<img src='"+testData.subTestPath()+"'></img>")
}

timer = {
  gettime: -> (new Date()).getTime()
  set_last: -> this.last = this.gettime()
  diff: -> this.gettime()-this.last
}

eventToChar = (event) -> String.fromCharCode(event.charCode)
showcase_klass = (klass) -> $('#showcase').hasClass(klass)

jQuery ->
  setupAjaxCallbacks()
  testData.downloadTestSequences()

  $(document).keypress( (event) ->
    iface.showNextSubTest()
    #if testData.subTestInd == -1
    #  iface.showNextSubTest()
    #else if eventToChar == testData.subTestKey()
    #  iface.showNextSubTest()
  )
