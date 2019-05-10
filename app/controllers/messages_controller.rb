class MessagesController < ApplicationController
  before_action :set_group

  def index
    # メッセージモデルの新しいインスタンスを生成
    @message = Message.new
    # グループに所属する全てのメッセージの情報のハッシュを配列に
    @messages = @group.messages.includes(:user)
  end

  def create
    # 現在のグループ、今入力されたメッセージのインスタンスを生成
    @message = @group.messages.new(message_params)
    @messages = @group.messages.all

    if @message.save
      # リクエストされたフォーマットによって処理をかえる
      respond_to do |format|
        format.html { redirect_to group_messages_path(params[:group_id]), notice: "メッセージが送信されました" }
        format.json
      end

    else
      # 現在のグループの全てのメッセージをもった配列？
      @messages = @group.messages.includes(:user) 
      flash.now[:alert] = "メッセージを入力してください。"
      # どのコントローラのindexアクション？
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:text, :image).merge(user_id: current_user.id)
  end

  def set_group
    # 現在のグループのインスタンスを生成
    @group = Group.find(params[:group_id])
  end
  
end
