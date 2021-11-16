SELECT 
	count(Produtos.product_id) Quantidade,
	Produtos.product_category_name Categoria,
	Clientes.customer_state Estado	
FROM olist_customers_dataset Clientes
INNER JOIN olist_orders_dataset Pedidos on Pedidos.customer_id = Clientes.customer_id
INNER JOIN olist_order_items_dataset Itens on Itens.order_id = Pedidos.order_id 
INNER JOIN olist_products_dataset Produtos on Produtos.product_id = Itens.product_id
group by Categoria, Estado
HAVING Quantidade > 1000
order by Estado, Quantidade DESC
