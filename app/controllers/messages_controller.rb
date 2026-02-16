class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation

  def create
    @message = @conversation.messages.build(message_params)
    @message.user = current_user

    if @message.save
      redirect_to @conversation
    else
      redirect_to @conversation, alert: "Message could not be sent."
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])

    # Ensure user is part of this conversation
    unless @conversation.sender == current_user || @conversation.recipient == current_user
      redirect_to conversations_path, alert: "You don't have access to this conversation."
    end
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
