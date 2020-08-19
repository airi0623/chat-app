class CreateRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :room_users do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      # room.id,user.idとしないんだ。テーブル同士の参照を意味してるからカラムで特定しないのかな。勝手にidだけ取ってきてくれるんだろうか。
      t.timestamps
      # カリキュラムに null: false入ってなかったけど、リードミーを作成した際に書いたので入れた。
    end
  end
end
