require './cart.rb'

describe "Cart" do
    it "1. Add items to cart and validate total and taxes (without imported)" do
        purch = Purchase.new
        purch.addProduct(2, "Books", "Book", 12.49, false)
        purch.addProduct(1, "Music CD", "Music", 14.99, false)
        purch.addProduct(1, "Chocolate bar", "FOOD", 0.85, false)

        expect(purch.total).to eq(42.32)
        expect(purch.basic_tax).to eq(1.5)
        expect(purch.import_tax).to eq(0)
    end

    it "2. Add items to cart and validate total and taxes (imported)" do
        purch = Purchase.new
        purch.addProduct(2, "Books", "Book", 12.49, true)
        purch.addProduct(1, "Chocolate bar", "FOOD", 0.85, true)
        import_taxes = 1.2 + 0.05
        total = 2*12.49 + 1*0.85 + import_taxes
        expect(purch.total).to eq(total.round(2))
        expect(purch.import_tax.round(2)).to eq(import_taxes.round(2))
    end
end
