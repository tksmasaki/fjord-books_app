# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable_type_and_id
  before_action :set_parent_instance

  def create
    comment = @parent_instance.comments.new(comment_params)
    if comment.save
      redirect_to @parent_instance, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to @parent_instance, flash: { errors: comment.errors }
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to @parent_instance, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_commentable_type_and_id
    type_and_id = request.path.split('/').slice(1, 2)
    @type = type_and_id[0].singularize.capitalize
    @id = type_and_id[1].to_i
  end

  def set_parent_instance
    @parent_instance = Object.const_get(@type).find(@id)
  end

  def comment_params
    params.require(:comment).permit(:comment).merge({ user_id: current_user.id })
  end
end
