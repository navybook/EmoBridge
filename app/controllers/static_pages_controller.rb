class StaticPagesController < ApplicationController
  skip_before_action :require_login

  def help
  end

  def privacy_policy
  end

  def terms_of_service
  end
end
