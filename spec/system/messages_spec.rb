
require 'rails_helper'

RSpec.describe "メッセージ投稿機能", type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @room_user = FactoryBot.create(:room_user)
    # @room_user = {room_id:___, user_id:____}
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、メッセージの送信に失敗すること' do
      # サインインする
      sign_in(@room_user.user) # @room_user.user = user_id
      #def sign_in(user)
      #  visit to_path
      #  fill_in "user_email", with: user.email
      #  fill_in "user_password", with: user.password
      #  click_on("Log in")
      #  expect(current_path).to eq root_path
      #end

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)
      # @room_user.room.name = roomテーブルのnameカラム

      # DBに保存されていないことを確認する
      expect{
        find('input[name="commit"]').click
      }.not_to change { Message.count }

      # 元のページに戻ってくることを確認する
      expect(current_path).to eq  room_messages_path(@room_user.room)
    end
  end

  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 値をテキストフォームに入力する
      text = "mukatuku"
      fill_in "message_content", with: text
      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq room_messages_path(@room_user.room)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(text)

    end
    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)
      #attach_file ()←スペース開けない！！！！

      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change {Message.count}.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq room_messages_path(@room_user.room)
      #make_visible: trueを付けることで非表示になっている要素も一時的に hidden でない状態になります。
      # ＊なんで隠してたらあかんのやろ

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")
    end
    it 'テキストと画像の投稿に成功すること' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)

      # 値をテキストフォームに入力する
      p = "ZECH::CAMP"
      fill_in "message_content", with: p

      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(p)

      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")
      # selectorスペルミス気をつけて 
    end
  end
end