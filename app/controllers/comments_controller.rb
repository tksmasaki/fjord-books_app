# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_parent_instance

  def create
    @comment = @parent_instance.comments.new(comment_params)
    if @comment.save
      redirect_to @parent_instance, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      instance_variable_set("@#{@type.singularize}", @parent_instance)
      @comments = @parent_instance.comments.eager_load(:user).order_by_oldest
      render "#{@type}/show"
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to @parent_instance, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_parent_instance
    @type, id = request.path.split('/').slice(1, 2)
    @parent_instance = Object.const_get(@type.singularize.capitalize).find(id.to_i)
  end

  def comment_params
    params.require(:comment).permit(:comment).merge({ user_id: current_user.id })
  end
end
