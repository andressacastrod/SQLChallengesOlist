--Crie uma view (SELLER_STATS) para mostrar por fornecedor, a quantidade de itens enviados, o tempo médio de postagem após a aprovação da compra, 
--a quantidade total de pedidos de cada Fornecedor, note que trabalharemos na mesma query com 2 granularidades diferentes.

CREATE VIEW SELLER_STATS
AS

SELECT
	Fornecedor,
	count(Item) Total_Pedidos,
	avg(Dias_para_postar) Media_Tempo_Postagem
FROM(
	SELECT
		Fornecedores.seller_id Fornecedor,
		Items.order_id Item,
		CAST((julianday(Pedidos.order_delivered_carrier_date) - julianday(Pedidos.order_approved_at)) as INTEGER) Dias_para_postar
	FROM olist_sellers_dataset Fornecedores
	INNER JOIN olist_order_items_dataset Items on Items.seller_id = Fornecedores.seller_id
	INNER JOIN olist_orders_dataset Pedidos on Pedidos.order_id = Items.order_id
)
GROUP by Fornecedor
ORDER by Total_Pedidos DESC
