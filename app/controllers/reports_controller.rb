# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report_with_author_name, only: %i[show edit]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @reports = Report.with_author_name.order_by_latest.page(params[:page])
  end

  def show; end

  def new
    @report = Report.new
  end

  def edit; end

  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id
    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def set_report_with_author_name
    @report = Report.with_author_name.find(params[:id])
  end

  def correct_user
    @report ||= Report.find(params[:id])
    redirect_to(root_url, notice: '不正な操作です') unless @report.user_id == current_user.id
  end
end
