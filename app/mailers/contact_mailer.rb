class ContactMailer < ApplicationMailer
    def contact_mail(photo)
        @photo = photo
        mail to: @photo.user.email, subject: "画像を投稿しました！"
    end
end
