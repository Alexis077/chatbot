# frozen_string_literal: true

class ReportsController < ApplicationController
  def show
    result = Reports::Show.call(report_params: report_params)
    respond_to do |format|
      format.pdf {send_data result.pdf, filename: "#{result.report_title}.pdf"}
    end
  end

  private

  def report_params
    params.permit(:id, :report_type)
  end
end
