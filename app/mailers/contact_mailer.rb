class ContactMailer < ApplicationMailer
    def send_when_create(photo)
        @photo = photo
        mail to: @photo.user.email,
            subject: "画像を投稿しました！"
    end
end
