--Crie uma tabela analítica de todos os itens que foram vendidos, mostrando somente pedidos interestaduais. 
--Queremos saber quantos dias os fornecedores demoram para postar o produto, se o produto chegou ou não no prazo.

SELECT *,
	CASE 
		WHEN Dias_para_entrega <= 0
			THEN 'No prazo'
		ELSE 'Atrasado'
	END Situação_entrega
FROM (
		SELECT 
			Items.*,
			Pedidos.*,
			Clientes.customer_state Estado_Compra,
			Vendedores.seller_state Estado_Venda,
			CAST((julianday(Pedidos.order_delivered_carrier_date) - julianday(Pedidos.order_approved_at)) as INTEGER) Dias_para_postar,
			CAST((julianday(Pedidos.order_delivered_customer_date) - julianday(Pedidos.order_estimated_delivery_date)) as INTEGER) Dias_para_entrega
		FROM olist_order_items_dataset Items
		INNER JOIN olist_orders_dataset Pedidos on Pedidos.order_id = Items.order_id
		INNER JOIN olist_customers_dataset Clientes on Clientes.customer_id	= Pedidos.customer_id
		INNER JOIN olist_sellers_dataset Vendedores on Vendedores.seller_id = Items.seller_id
		WHERE Estado_Compra <> Estado_Venda
			AND Pedidos.order_status = 'delivered'
		)