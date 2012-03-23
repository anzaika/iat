postResult = ->
  $.ajax({
    type: "POST",
    url: "/results.json",
    dataType: "json",
    contentType: "application/json",
    data: JSON.stringify(test)
  })

timer = {
  gettime: ->
    now = new Date()
    return now.getTime()
  set_last: ->
    this.last = this.gettime()
  diff: ->
    this.gettime()-this.last
}

test = {
 times: []
 error: 0
}

to_chr   = (event) -> String.fromCharCode(event.charCode)
showcase_klass = (klass) -> $('#showcase').hasClass(klass)

jQuery ->
  sub_test = 1
  $(document).keypress( (event) ->
    if showcase_klass('init')
      $('#place').load("/next")
      timer.set_last()
    else
      if $("#tt").hasClass(sub_test)
        test.times.push(timer.diff())
        postResult()
        $('#place').load("/next")
      else
        if showcase_klass(to_chr(event))
          sub_test++
          test.times.push(timer.diff())
          $('#place').load("/next")
          timer.set_last()
        else
          test.error++
          $('#showcase').append('<div class="alert alert-error">Неправильно</div>')
          timer.set_last()
  )
