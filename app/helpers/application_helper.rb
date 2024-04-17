module ApplicationHelper
  def icon_for_feeling(feeling)
    case feeling
    when 'happy'
      'fa-regular fa-face-laugh-beam'
    when 'smile'
      'fa-regular fa-face-smile-beam'
    when 'normal'
      'fa-regular fa-face-grin-wide'
    when 'tired'
      'fa-regular fa-face-tired'
    when 'exhausted'
      'fa-regular fa-face-dizzy'
    else
      '' # 感情が指定されていないか、未知の場合はアイコンなし
    end
  end
end
