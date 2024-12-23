class Plan < ApplicationRecord
  belongs_to :group
  has_many :plan_destinations
  has_many :destinations, through: :plan_destinations, dependent: :destroy
  has_many_attached :images

  validates :title, presence: true, length: { maximum: 25 }
  validates :start_date, :end_date, presence: true
  validates :images, content_type: { in: ['image/png', 'image/jpeg'], message: 'の形式が対応していません。対応形式はPNGまたはJPEGです。' }
  validate :start_date_is_before_end_date
  validate :no_more_than_3_photos

  def start_date_is_before_end_date
    if start_date.present? && end_date.present? && start_date > end_date
      errors.add(:end_date, "は開始日より後の日付にしてください。")
    end
  end

  def no_more_than_3_photos
    if images.attached? && images.count > 3
      errors.add(:images, "は3枚以内にしてください。")
    end
  end

  def self.generate_travel_plan(destinations, start_date, end_date)
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          {
            role: "system",
            content: "あなたは優秀な旅行プランナーです。条件を基に、あなたのおすすめも行程に盛り込みながら、最適な旅行プランを500文字以内の日本語で提案してください。",
          },
          {
            role: "user",
            content: <<~TEXT,
            旅程は、#{start_date}から#{end_date}です。絶対に立ち寄る場所は、#{destinations}です。

            以下の条件に従って、旅行プランを作成してください：
            - 昼食、夕食にはできるだけその土地のグルメを楽しむ
            - 各スポットや追加のおすすめについて、数行で詳細を説明する
            - 見出しや改行を使って読みやすくする
            - 最後に、その土地の紹介とお土産等の追加の旅行ポイントも教えてください
          TEXT
          },
        ],
      }
    )
    response.dig("choices", 0, "message", "content")
  end
end
