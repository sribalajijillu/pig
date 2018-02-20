txn  =  LOAD  '/home/hduser/Downloads/txns1.txt'  USING PigStorage(',')  AS  ( txnid, date, custid, amount:double, category, product, city, state, type);
--dump txn;
cust = load  '/home/hduser/Downloads/custs'  using  PigStorage(',')  AS ( custid, firstname, lastname, age:long, profession);
--dump cust;
txnbyid = group txn by custid;
--dump txnbyid;
spendbycust = foreach  txnbyid  generate group as customer_id,  ROUND_TO(SUM(txn.amount ),2) as totalsales;
--dump spendbycust;
tot500 = filter spendbycust by totalsales>500;
--dump tot500;
--describe tot500;
cust500 = join tot500 by $0, cust by $0;
--dump cust500;
cust500 = foreach cust500 generate $0, $1, $3, $4, $5, $6;
--dump cust500;
age5 = filter cust500 by $4 < 50;
--dump age5;
groupall = group age5 all;
--describe groupall;
--groupall: {group: chararray,age5: {(tot500::customer_id: bytearray,tot500::totalsales: double,cust::firstname: bytearray,cust::lastname: bytearray,cust::age: long,cust::profession: bytearray)}}
totcount = foreach groupall generate COUNT(age5);
dump totcount;

