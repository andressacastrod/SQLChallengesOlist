--Mostre o valor vendido total de cada vendedor (seller_id) em cada uma das categorias de produtos, omente retornando os vendedores que nesse somatório e agrupamento venderam mais de $1000. 
--Desejamos ver a categoria do produto e os vendedores. Para cada uma dessas categorias, mostre seus valores de venda de forma decrescente.

SELECT
		Produtos.product_category_name Categoria,
		sum(Items.price) Valor_Total,
		Vendedores.seller_id Vendedor
FROM olist_sellers_dataset Vendedores
INNER JOIN olist_order_items_dataset Items on Items.seller_id = Vendedores.seller_id
INNER JOIN olist_products_dataset Produtos on Produtos.product_id = Items.product_id
GROUP by Categoria, Vendedor
HAVING Valor_Total > 1000
order by Categoria, Valor_Total DESC