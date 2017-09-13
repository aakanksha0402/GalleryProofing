class InvoiceTemplateController < ApplicationController

  def index
    @templates = current_brand.invoices.where(is_template: true)
  end
  def show_items
    puts params
    @invoice_line_items = InvoiceLineItem.where(invoice_id: params[:id])
    respond_to do |format|
      format.js
    end
  end

  def delete_template
    puts params
    @template = Invoice.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  def delete_invoice_template
    puts params
    @template = Invoice.find(params[:id])
    @template.destroy
    respond_to do |format|
      format.js
    end
  end
end
