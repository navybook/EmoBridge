FactoryBot.define do
  # Emotionモデルのファクトリを定義
  factory :emotion do
    user # Emotionはユーザーに関連しているため、関連するユーザーを自動的に作成

    # 感情のenumのキーからランダムに選択
    feeling { Emotion.feelings.keys.sample }

    # 感情の評価スコアを1から5の範囲でランダムに設定
    feeling_score { rand(1..5) }

    # カテゴリ付きのEmotionを作成するサブファクトリ
    factory :emotion_with_categories do
      transient do
        # デフォルトで3つのカテゴリを作成する設定
        categories_count { 3 }
      end

      # Emotionが作成された後に、指定された数のEmotionCategoryを作成し関連付ける
      after(:create) do |emotion, evaluator|
        create_list(:emotion_category, evaluator.categories_count, emotion: emotion)
      end
    end

    # メッセージ付きのEmotionを作成するサブファクトリ
    factory :emotion_with_message do
      # Emotionが作成された後に、EmotionMessageを作成し関連付ける
      after(:create) do |emotion, _evaluator|
        create(:emotion_message, emotion: emotion)
      end
    end
  end
end
