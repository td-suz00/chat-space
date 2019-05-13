class Api::MessagesController < ApplicationController
  before_action :set_group

  def index
    @messages = @group.messages.where('id > ?', params[:last_id])

    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  def set_group
    # 現在のグループのインスタンスを生成
    @group = Group.find(params[:group_id])
  end

end 
