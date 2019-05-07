require 'rails_helper'

describe MessagesController do
  let(:group){ create(:group) }
  let(:user){ create(:user) }

  # ここからindexアクション
  describe 'GET #index' do
    # ログインしている場合
    context 'login' do
      before do
        # controller_macros.rb内のメソッドの呼び出し
        login user
        get :index, params: { group_id: group.id }
      end

      # @messageのインスタンス変数があるかどうか
      it 'assigns @message' do
        expect(assigns(:message)).to be_a_new(Message)
      end

      # before_action :set_group で@groupを生成しているのであるかどうか
      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end

      # indexビューがあるかどうか
      it 'renders index' do
        expect(response).to render_template :index
      end
    end

    # ログインしていない場合
    context 'not login' do
      before do
        get :index, params: { group_id: group.id }
      end

      # ログイン画面にリダイレクトされるか
      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end

    end

  end


  # ここからcreateアクション
  describe 'GET #create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    # ログインしている場合
    context 'login' do
      before do
        # controller_macros.rb内のメソッドの呼び出し
        login user
      end

      # 保存された場合
      context 'can save' do
        # expectの引数が長くなってしまうので、subjectとして定義
        subject{
          post :create, params: params
        }
        
        # メッセージの保存はできたのか
        it 'count up message' do
          expect{ subject }.to change(Message, :count).by(1)
        end
  
        # group_messages_pathにリダイレクトされるか
        it 'redirects to group_messages_path' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      # 保存されなかった場合
      context 'can not save' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message,text: nil, image: nil) } }

        subject{
          post :create, params: invalid_params
        }
  
        # メッセージの保存はされなかったのか
        it 'does not count up message' do
          expect{ subject }.not_to change(Message, :count)
        end
  
        # index画面にリダイレクトされるか
        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    # ログインしていない場合
    context 'not login' do

      # 非ログイン時に、ログイン画面にリダイレクトされるか
      it 'redirects to new_user_session_path' do
        get :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end

    end

  end
end
