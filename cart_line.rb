class Cart_Line
    attr_accessor :quantity, :product, :taxes, :total
    def initialize(quantity, product)
        @quantity = quantity
        @product = product
        @taxes = quantity * product.taxes
        @total = quantity * product.price + @taxes
    end
end