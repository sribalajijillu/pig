retail = load '/niit/retail/D12' using PigStorage(';') as (date, cust_id, age, area, category, pid, qty, cost, sales:long);
grp = group retail by pid;
--dump grp;
pid_sum = foreach grp generate group as pid, SUM(retail.sales);
--dump pid_sum;
final = limit(order pid_sum by $1 desc) 10;
dump final;
