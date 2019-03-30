CREATE OR REPLACE FUNCTION update_product_inventory(ProductId uuid , Quantity int) RETURNS TRIGGER AS
$BODY$
BEGIN

	UPDATE Product
		SET Product.count =Product.count - Quatity
		WHERE Product.id = ProductId;

	RETURN null;

END;

CREATE TRIGGER update_product AFTER INSERT ON Transaction
For EACH ROW EXECUTE PROCEDURE update_product_inventory();
