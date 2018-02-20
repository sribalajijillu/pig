cust = load '/home/hduser/Pig/custs' using PigStorage(',') as (cus_id, fname, lname, age, profession:chararray);
--dump cust;
custbyprof = group cust by profession;
--dump custbyprof;
profcount = foreach custbyprof generate group as profession, COUNT(cust) as number;
--dump profcount;
prof_order = order profcount by $1 desc;
dump prof_order;

