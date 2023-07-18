# frozen_string_literal: true

module Reports
  class Show
    include Interactor
    include Errors::Handler

    REPORT_SETTINGS = { "purchase_request" => { template: "/reports/purchase_request_report",
                                           model: PurchaseRequest, 
                                           title: "Reporte de solicitud de rollos"}}

    def call
      generate_report!
      generate_pdf!
    end

    private

    def generate_report!
      report_settings = REPORT_SETTINGS[context.report_params[:report_type]]
      context.report_title= report_settings[:title]
      context.report_template= report_settings[:template]
      context.data = report_settings[:model].find(context.report_params[:id]) 
    end

    def generate_pdf!
      pdf_html = ActionController::Base.new.render_to_string(assigns: { data: context.data }, template: context.report_template, layout: 'pdf')
      context.pdf = WickedPdf.new.pdf_from_string(pdf_html)
    end
  end
end
