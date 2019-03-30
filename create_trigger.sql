CREATE TRIGGER product_inventory_update
	ON TRANSACTION
	AFTER INSERT
	AS 
BEGIN
	DECLARE 
	@ProductId numeric,
	@Quantity numeric

	SELECT @ProductId = INSERTED.Product_Id,
		@Quantity = INSERTED.quantity
	FROM INSERTED

	UPDATE Inventory
		SET QUANTITY = QUANTITY - @Quatity
		WHERE Product_Id = @ProductId
END;
