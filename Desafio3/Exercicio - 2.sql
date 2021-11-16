--Retorne todos os pagamentos do cliente, com suas datas de aprovação, valor da compra e o valor total que o cliente já gastou em todas as suas compras, 
--mostrando somente os clientes onde o valor da compra é diferente do valor total já gasto.

SELECT
	Clientes.customer_unique_id Cliente,
	Pagamentos.order_id Pagamento,
	Pagamentos.payment_value Valor,
	Pedidos.order_approved_at Data_Aprovação,
	sum(Pagamentos.payment_value) Valor_Total
FROM olist_customers_dataset Clientes
INNER JOIN olist_orders_dataset Pedidos on Pedidos.customer_id = Clientes.customer_id
INNER JOIN olist_order_payments_dataset Pagamentos on Pagamentos.order_id = Pedidos.order_id
GROUP by Cliente
HAVING Valor <> Valor_Total

