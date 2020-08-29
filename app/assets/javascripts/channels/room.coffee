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

    $(document).on 'click', '.message_sendbtn', (event) ->
      App.room.speak $('.message_text').val();
      $('.message_text').val('');
      event.preventDefault()
