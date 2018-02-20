sales = load '/home/hduser/Pig/txns1.txt' using PigStorage(',') as (txnid, date, custid, amount:double, category, product, city, state, type);
--dump sales;
grp_sales = group sales all;
--dump grp_sales;
tot_sales = foreach grp_sales generate ROUND_TO(SUM(sales.amount),2);
dump tot_sales; 
