App.game = App.cable.subscriptions.create "GameChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('.status')
      .html data.content
    if data.command == 'win'
      $('.xo:input[value=""]').attr('disabled', 'disabled')
      s = data.cell
      l = s.length
      i = 0
      while i < l
        console.log $("##{s[i]}")
        $("##{s[i]}").val("#{data.val}")
        $("##{s[i]}").css 'background-color', 'rgb(181, 192, 73)'
        $("##{s[i]}").attr('disabled', 'disabled')
        i++
    else if data.command == 'no one'
      $("##{data.cell}").val("#{data.val}")
      $('.xo:input[value=""]').attr('disabled', 'disabled')
      $("##{data.cell}").attr('disabled', 'disabled')
    else if data.command == 'joined'
      $("##{data.cell}").val("#{data.val}")
      $('.xo:input[value=""]').attr('disabled', false)
    else if data.command == 'next'
      $("##{data.cell}").val("#{data.val}")
      $('.xo:input[value=""]').attr('disabled', false)
      $("##{data.cell}").attr('disabled', 'disabled')
