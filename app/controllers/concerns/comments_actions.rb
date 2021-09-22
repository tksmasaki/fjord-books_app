# frozen_string_literal: true

module CommentsActions
  def set_comments_form
    @comment = Comment.new
    return if flash[:errors].blank?

    # エラー発生後にリダイレクトされた際、渡されたメッセージを追加する
    flash[:errors].each do |k, v|
      v.each do |message|
        @comment.errors.add(k, message)
      end
    end
  end

  def set_comments_index
    @comments = comments_parent_instance.comments.eager_load(:user).order_by_oldest
  end

  private

  def comments_parent_instance
    raise NotImplementedError
  end
end
