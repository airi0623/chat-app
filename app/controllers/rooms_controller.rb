class RoomsController < ApplicationController

  def new
    @room = Room.new #newはアクションではなくnewメソッド
    # @roomはインスタンス(テーブルのレコードデータのこと)
  end

  def create
    @room = Room.new(room_params)
    # ()下のメソッドから取ってきてる
      if @room.save
        redirect_to root_path
      else
        render :new
      end
  end

  private
  def room_params
    params.require(:room).permit(:name, user_ids:[])
    # roomモデルに:name, user_ids:の新規作成を許可している。
    # * user_ids:カラムないのにどうやって保存するのでしょうか？
  end

end
