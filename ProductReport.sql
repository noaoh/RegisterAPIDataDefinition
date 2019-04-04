SELECT transaction.product, SUM(transaction.quantity) AS totalquantity, SUM(transaction.totalcost) AS totalcost from transaction group by product order by SUM(transaction.totalcost) desc limit 10;
