class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :messages

  validates :name, presence: true

  def show_lase_message
    # 最後のメッセージをlase_message変数に入れつつ、あるかどうかを判定
    if (last_message = messages.last).present?
      # 三項演算子　条件式 ? trueの時の値 : falseの時の値
      last_message.text? ? last_message.text : "画像が投稿されています"
    else
      "まだメッセージはありません"
    end
  end
end
