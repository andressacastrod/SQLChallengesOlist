--Mostre os 5 clientes (customer_id) que gastaram mais dinheiro em compras, qual foi o valor total de todas as compras deles, quantidade de compras, e valor médio gasto por compras. Ordene os mesmos por ordem decrescente pela média do valor de compra.

SELECT *
FROM (
		SELECT
			Clientes.customer_unique_id Cliente,
			sum(Pagamentos.payment_value) Valor_Total,
			count(Pedidos.order_id) Total_Pedidos,
			avg(Pagamentos.payment_value) Valor_Medio
		FROM olist_customers_dataset Clientes
		INNER JOIN olist_orders_dataset Pedidos on Clientes.customer_id	= Pedidos.customer_id
		INNER JOIN olist_order_payments_dataset Pagamentos on Pedidos.order_id = Pagamentos.order_id
		 group by Cliente
		 order by Valor_Total desc
		 LIMIT 5
	) order by Valor_Medio DESC