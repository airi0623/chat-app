class UsersController < ApplicationController

  def exdit
  end

  def update
    if current_user.update(user_params)
      # current_user：サインインしているユーザーの情報を取得するメソッド
        # DATA=[{name:〇〇},[{email:〇〇},[{password:〇〇},[{passwordconfimation:〇〇}
        # 仮説）current_userではコメント内容まではデータとして持っていないはず。モデル、テーブルが違うので
      #user_params:メソッド名なのでスネークケースで記載している＊命名規則なので守らないといけない
      ridirect_to root_path #
    else
      render :edit # 表示させたいビューのアクション
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
    # @モデルの前には：がつく？？     こっちはシンボル（キー）
  end
end
