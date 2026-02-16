class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show]

  def index
    @conversations = current_user.conversations.includes(:sender, :recipient, :messages)
  end

  def show
    @other_user = @conversation.other_party(current_user)
    @messages = @conversation.messages.order(created_at: :asc)
    @message = Message.new

    # Mark messages as read
    @conversation.unread_messages_for(current_user).update_all(read: true)
  end

  def create
    recipient = User.find(params[:recipient_id])

    # Check if conversation already exists
    @conversation = Conversation.between(current_user.id, recipient.id).first

    if @conversation.nil?
      @conversation = Conversation.create!(sender: current_user, recipient: recipient)
    end

    redirect_to @conversation
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])

    # Ensure user is part of this conversation
    unless @conversation.sender == current_user || @conversation.recipient == current_user
      redirect_to conversations_path, alert: "You don't have access to this conversation."
    end
  end
end
