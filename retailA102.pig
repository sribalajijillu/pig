retail = load '/niit/retail/D02' using PigStorage(';') as (date, cust_id, age, area, category, pid, qty, cost, sales:long);
--dump retail;
groupall = group retail all;
--dump groupall;
max_retail = foreach groupall generate MAX(retail.sales) as max;
--dump max_retail;
final = filter retail by sales == (max_retail.max);
--dump final;
final =foreach final generate $0, $1, $8;
dump final;

