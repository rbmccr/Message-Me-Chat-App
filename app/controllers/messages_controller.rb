class MessagesController < ApplicationController

  def create
    message = current_user.messages.build(message_params)
    if message.save
      # data sent to coffeescript file
      ActionCable.server.broadcast "chatroom_channel", item: message_render(message)
    end
  end

  private
  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: "message", locals: {message: message})
  end

end