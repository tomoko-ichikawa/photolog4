class CommentsController < ApplicationController
  def create
      # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
      @photo = Photo.find(params[:photo_id])
      @comment = @photo.comments.build(comment_params)
      # クライアント要求に応じてフォーマットを変更
      respond_to do |format|
          if @comment.save
              format.js { render :index }
              else
              format.html { redirect_to photo_path(@photo), notice: '投稿できませんでした...' }
          end
      end
  end
  
  private
  # ストロングパラメーター
  def comment_params
      params.require(:comment).permit(:photo_id, :content)
  end
  
end
