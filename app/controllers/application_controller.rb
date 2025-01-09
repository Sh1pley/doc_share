class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def set_flash(type, message, now = nil)
    now ? flash.now[type] = message : flash[type] = message
  end
end
