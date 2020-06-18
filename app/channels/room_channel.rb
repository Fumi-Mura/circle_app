class RoomChannel < ApplicationCable::Channel
  
  def subscribed
    stream_from "room_channel_#{params['room']}"
  end
  
  def unsubscribed
  end

  def speak(data)
    Message.create! content: data['message'], user_id: current_user.id, room_id: params['room']
  end
end