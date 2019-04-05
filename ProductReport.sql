SELECT product.lookupcode, SUM(transaction.quantity) AS totalquantity, SUM(transaction.totalcost) AS totalcost from transaction, product where product.id = transaction.product group by product.lookupcode order by SUM(transaction.totalcost) desc limit 10;