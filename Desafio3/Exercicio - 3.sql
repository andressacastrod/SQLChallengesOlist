--Retorne as categorias válidas, suas somas totais dos valores de vendas, 
--um ranqueamento de maior valor para menor valor junto com o somatório acumulado dos valores pela mesma regra do ranqueamento.

SELECT
	Categoria,
	Valor_Total,
	Rank_Valor,
	sum(Valor_Total) over (order by Rank_Valor DESC) as Soma_Acumulada
FROM (
		SELECT
			product_category_name Categoria,
			sum(Items.price) Valor_Total,
			rank () over (order by sum(Items.price)) as Rank_Valor
		FROM olist_products_dataset Produtos
		INNER JOIN olist_order_items_dataset Items on Items.product_id = Produtos.product_id
		WHERE Categoria is not NULL
		GROUP by Categoria
	)
order by Rank_Valor DESC