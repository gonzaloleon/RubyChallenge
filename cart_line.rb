class Cart_Line
    attr_accessor :quantity, :product
    def initialize(quantity, product)
        @quantity = quantity
        @product = product
    end
end