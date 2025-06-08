# frozen_string_literal: true

# This controller handles top-related actions
class TopsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index; end

  def home
      @background_images = ['image1.jpg', 'image2.jpg', 'image3.jpg', 'image4.jpg', 'image5.jpg']
      @random_image = @background_images.sample
  end
end
