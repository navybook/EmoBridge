class UpdateFeelingForExistingData < ActiveRecord::Migration[7.1]
  def up
      Emotion.where(feeling: 'exhausted').update_all(feeling: 'tired')
      Emotion.where(feeling: 'smile').update_all(feeling: 'happy')
  end

  def down
      Emotion.where(feeling: 'tired').update_all(feeling: 'exhausted')
      Emotion.where(feeling: 'happy').update_all(feeling: 'smile')
  end
end
