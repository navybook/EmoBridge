# This module provides helper methods for the application.
# frozen_string_literal: true

module ApplicationHelper
  def icon_for_feeling(feeling)
    case feeling
    when 'happy'
      'fa-regular fa-face-laugh-beam'
    when 'normal'
      'fa-regular fa-face-grin-wide'
    when 'tired'
      'fa-regular fa-face-tired'
    when 'sad'
      'fa-regular fa-face-sad-tear'
    when 'angry'
      'fa-regular fa-face-angry'
    else
      ''
    end
  end

  def default_meta_tags
    {
      site: 'EmoBridge',
      title: 'EmoBridge | 円満なコミュニケーションを図るアプリ',
      reverse: true,
      separator: '|',
      description: 'EmoBridgeで感情を記録、可視化し、パートナーと共有しお互いの理解を深めることで、円満な関係を築く感情共有アプリ',
      keywords: %w[感情記録 感情共有 コミュニケーション],
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('Emobridge.webp'),
        locale: 'ja_JP'
      }
    }
  end
end
