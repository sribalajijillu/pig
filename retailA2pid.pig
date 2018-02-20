retail = load '/niit/retail' using PigStorage(';') as (date, cust_id, age, area, category, pid, qty, cost:long, sales:long);
--grp = group retail by pid;
profit_pid = foreach retail generate $5, (sales-cost) as profit;
grp = group profit_pid by $0;
--dump grp;
prosum = foreach grp generate $0, SUM(profit_pid.profit);
--dump prosum; 
orderbydesc = limit(order prosum by $1 desc) 10;
dump orderbydesc;

