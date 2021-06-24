require "./product.rb"
require "./cart_line.rb"

class Cart
	attr_accessor :cart_lines, :total, :taxes
	def initialize()
		@cart_lines = []
		@total = 0
		@taxes = 0
    end
    
	def addProduct(quantity, name, type, price, imported)
	  prod = Product.new(name, type, price, imported)
	  line = Cart_Line.new(quantity, prod)
      cart_lines.push line
	  @taxes += line.taxes
	  @total += line.total
    end
	
	def closeInvoice()
		if @cart_lines.empty?
			puts "There is no products in your cart - $ 0"
			return
		end

		@cart_lines.each do |line|
			puts "#{line.quantity} #{line.product.name}: $ #{line.total.round(2)}"
		end
		puts "-----------------------"
		puts "Sales Taxes: #{taxes.round(2)}"
		puts "Total $ #{total.round(2)}"
	end
end

if __FILE__ == $0
  
  puts "-> INPUT 1 "
  puts ""
  
  purch = Cart.new
  purch.addProduct(2, "Books", "Book", 12.49, false)
  purch.addProduct(1, "Music CD", "Music", 14.99, false)
  purch.addProduct(1, "Chocolate bar", "FOOD", 0.85, false)
  
  purch.closeInvoice()
  
  puts ""
  puts "-> INPUT 2 "
  puts ""
  
  purch = Cart.new
  purch.addProduct(1, "Box of chocolates", "FOOD", 10.00, true)
  purch.addProduct(1, "Bottle of perfume", "OTHER", 47.50, true)
  
  purch.closeInvoice()
  
  puts ""
  puts "-> INPUT 3 "
  puts ""
  
  purch = Cart.new
  purch.addProduct(1, "Bottle of perfume A", "Others", 27.99, true)
  purch.addProduct(1, "Bottle of perfume B", "Others", 18.99, false)
  purch.addProduct(1, "Pack of headache pills", "MEDICINE", 9.75, false)
  purch.addProduct(3, "Boxes of chocolate", "FOOD", 11.25, true)
  
  purch.closeInvoice()
end