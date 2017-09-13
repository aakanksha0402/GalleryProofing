class InvoiceLineItem < ActiveRecord::Base
  belongs_to :brand
  belongs_to :invoice

  #validation
  validates :name, presence: { message: "Please enter the name for Line Item." }
  validates :description, presence: { message: "Please enter the description for Line Item." }
  validates :quantity, presence: { message: "Please enter the quantity for Line Item." }
  validates :quantity, numericality: { message: "Please Enter Number only"}
  validates_numericality_of :quantity, :only_integer => true, :greater_than_or_equal_to => 1
  validates :price, presence: { message: "Please enter the price for Line Item." }
  validates :price, numericality: { message: "Please Enter Number only"}
  validates_numericality_of :price, :only_integer => true, :greater_than_or_equal_to => 1



  def calculations
    puts self.as_json
    puts "____________"
    @a = self.price
    @b = self.quantity
    @tax_rate = Invoice.find(self.invoice_id)
    puts @tax_rate.as_json
    if @tax_rate.sales_rate.present?
      @tax = (@a*@b*@tax_rate.sales_rate)/100
    end
    return @a*@b,@tax
  end
end
