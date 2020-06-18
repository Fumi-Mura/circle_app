App.room = App.cable.subscriptions.create "RoomChannel",
  document.addEventListener 'turbolinks:load', ->
    if App.room
      App.cable.subscriptions.remove App.room
    App.room = App.cable.subscriptions.create { channel: "RoomChannel", room: $('#messages').data('room_id') },
      connected: ->
        
      disconnected: ->
        
      received: (data) ->
        $('#messages').append data['message']
      speak: (message) ->
        @perform 'speak', message: message
    $('#chat-input').on 'keypress', (event) ->
      if event.keyCode is 13
        App.room.speak event.target.value
        event.target.value = ''
        event.preventDefault();