require './cart.rb'

describe "Cart" do
    it "1. Add items to cart and validate total and taxes (without imported)" do
        purch = Cart.new
        purch.addProduct(2, "Books", "Book", 12.49, false)
        purch.addProduct(1, "Music CD", "Music", 14.99, false)
        purch.addProduct(1, "Chocolate bar", "FOOD", 0.85, false)

        expect(purch.total).to eq(42.32)
        expect(purch.taxes).to eq(1.5)
    end

    it "2. Add items to cart and validate total and taxes (imported)" do
        purch = Cart.new
        purch.addProduct(2, "Books", "Book", 12.49, true)
        purch.addProduct(1, "Chocolate bar", "FOOD", 0.85, true)
        taxes = 1.20 + 0.05
        total = 2*12.49 + 1*0.85 + taxes
        expect(taxes.round(2)).to eq(purch.taxes.round(2))
        expect(total.round(2)).to eq(purch.total.round(2))
    end
end
