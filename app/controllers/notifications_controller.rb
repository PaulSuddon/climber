class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.recent
    # Mark all as read when viewing the notifications page
    current_user.notifications.unread.update_all(read: true)
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    @notification.mark_as_read!
    redirect_back(fallback_location: notifications_path)
  end

  def mark_all_as_read
    current_user.notifications.unread.update_all(read: true)
    redirect_to notifications_path, notice: "All notifications marked as read."
  end
end
