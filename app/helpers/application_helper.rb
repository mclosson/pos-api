module ApplicationHelper

  def current_user
    if @current_user.nil?
      user = Rails::cache.read("user_#{@apikey.user_id}")
      if user.nil?
        user = User.find(@apikey.user_id)
        Rails::cache.write("user_#{@apikey.user_id}", user)
        @current_user = user
      end
    end
        
    return @current_user
  end

end
