class ReportsController < ApplicationController

  def gallery_visitors
    @gallery_visitors = GalleryVisitor.where(is_delete: false)
    @contacts = Contact.all
    respond_to do |format|
      format.html
      format.csv { send_data @gallery_visitors.to_csv, filename: "GalleryVisitor-#{Date.today}.csv" }
    end
  end

  def sales
    @checkouts = current_brand.checkouts
    @checkouts = @checkouts.order_year(params[:year]) if params[:year].present?
    @shipping_options = ShippingOption.all
    respond_to do |format|
      format.html
      format.csv { send_data @checkouts.sales_csv(), filename: "sales-#{Date.today}.csv" }
    end
  end

  def orders
    @checkouts = current_brand.checkouts
    @checkouts = @checkouts.order_year(params[:year]) if params[:year].present?
    @shipping_options = ShippingOption.all
    respond_to do |format|
      format.html
      format.csv { send_data @checkouts.csv(), filename: "orders-#{Date.today}.csv" }
    end
  end

  def ordered_files
    @checkouts = current_brand.checkouts
    @checkouts = @checkouts.order_year(params[:year]) if params[:year].present?
    @gallery = Gallery.includes({gallery_visitors: [:checkouts]}).where(checkouts: {id: @checkouts.ids})
    @checkouts = @checkouts.joins(:gallery_visitor => [:gallery]).where("galleries.id = ? ", params[:gallery] ) if params[:gallery].present?
    respond_to do |format|
      format.html
      format.csv { send_data @checkouts.to_csv(), filename: "ordered-files-#{Date.today}.csv" }
    end
  end

  def items
    @line_items = LineItem.all.uniq.select('catalog_id')
    @line_items1 = LineItem.all
    @line_items = @line_items.days_ago(params[:days]) if params[:days].present?
    puts @line_items
    respond_to do |format|
      format.html
      format.csv { send_data @line_items.to_csv(@line_items1), filename: "items-#{Date.today}.csv" }
    end
  end

  def invoice_payments
    @invoice_payment = AddPayment.joins(:invoice).where(invoices: {brand_id: current_brand.id})
    respond_to do |format|
      format.html
      format.csv { send_data @invoice_payment.to_csv, filename: "payments-#{Date.today}.csv" }
    end
  end

  def client_email_cart
    @gallery_visitor = GalleryVisitor.find_by(email: params[:email],gallery_id: params[:gallery_id])
    puts @gallery_visitor.as_json
    @carts = @gallery_visitor.carts

  end

end
