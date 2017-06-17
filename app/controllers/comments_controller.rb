class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    respond_to do |format|
     if @comment.save
       format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
       format.js { render :index }
       Pusher.trigger('test_channel', 'comment_created', {
          message: 'あなたの作成したブログにコメントが付きました'
        })
     else
       format.html { render :new }
     end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @blog = @comment.blog
    respond_to do |format|
      @comment.destroy
      format.html { redirect_to blog_path(@blog), 'コメントを削除しました。' }
      format.js { render :index }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end
end
