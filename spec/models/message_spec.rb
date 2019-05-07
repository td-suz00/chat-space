require 'rails_helper'

describe Message, type: :model do
  describe '#create' do

    context 'can save' do
      # メッセージがあれば保存できる
      it "is valid with a text" do
        message = build(:message, image: nil)
        expect(message).to be_valid
      end

      # 画像があれば保存できる
      it "is valid with a image" do
        message = build(:message, text: nil)
        expect(message).to be_valid
      end

      # メッセージと画像があれば保存できる
      it "is valid with a text,image" do
        message = build(:message)
        expect(message).to be_valid
      end

    end

    context 'cannnot save' do
      # メッセージも画像も無いと保存できない
      it "is invalid without a text or image" do
        message = build(:message, text: nil, image: nil)
        message.valid?
        expect(message.errors[:text]).to include("を入力してください")
      end

      # group_idが無いと保存できない
      it "is invalid without a group_id" do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end

      # user_idが無いと保存できない
      it "is invalid without a user_id" do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end

    end

  end
end

