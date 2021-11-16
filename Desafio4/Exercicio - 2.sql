--Queremos dar um cupom de 10% do valor da última compra do cliente. 
--Porém os clientes elegíveis a este cupom devem ter feito uma compra anterior a última (a partir da data de aprovação do pedido) que tenha sido maior ou igual o valor da última compra. 
--Crie uma querie que retorne os valores dos cupons para cada um dos clientes elegíveis.

SELECT 
	*,
	Valor_Pago*0.1 Valor_Cupom
FROM (
	SELECT 
		*,
		lag(Valor_Pago) over (PARTITION by customer_unique_id order by order_approved_at) Valor_Anterior,
		row_number() OVER (PARTITION by customer_unique_id order by order_approved_at DESC) Ordem_Pedido
	FROM (
		SELECT 
			Clientes.customer_unique_id,
			Pedidos.order_id,
			Pedidos.order_approved_at,
			sum(Pagamentos.payment_value) as Valor_Pago,
			count(Pedidos.order_id) over (PARTITION by Clientes.customer_unique_id) Quant_Pedidos
		FROM olist_order_payments_dataset Pagamentos
		INNER JOIN olist_orders_dataset Pedidos on Pedidos.order_id = Pagamentos.order_id
		INNER JOIN olist_customers_dataset Clientes on Clientes.customer_id = Pedidos.customer_id
		WHERE Pedidos.order_approved_at is not NULL
		GROUP by Clientes.customer_unique_id, Pedidos.order_id, Pedidos.order_approved_at
		ORDER by Clientes.customer_unique_id, Pedidos.order_approved_at
	) WHERE Quant_Pedidos > 1
) WHERE Ordem_Pedido = 1 AND Valor_Anterior >= Valor_Pago