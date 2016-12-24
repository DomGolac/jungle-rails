class Mailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_receipt(order)
    @order = order
    @items = []
    line_items = LineItem.where order_id: @order.id
    line_items.each do |line_item|
      product = Product.find(line_item.product_id)
      @items.push(product)
    end
    subject_line = 'Your order #' + order.id.to_s + ' receipt from Jungle'
    mail to: '<email_address>', subject: subject_line
  end

end
