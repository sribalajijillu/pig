retail = load '/niit/retail' using PigStorage(';') as (date, cust_id, age, area, category, pid, qty, cost:double, sales:double);
retail = foreach retail generate $5, $7, $8;
grp = group retail by $0;
procent = foreach grp generate $0, ROUND_TO((SUM(retail.$2)-SUM(retail.$1))/SUM(retail.$1)*100,2) as percent;
orderbydesc = limit(order procent by percent desc) 10;
dump orderbydesc;

