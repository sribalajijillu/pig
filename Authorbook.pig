author_data =  LOAD  '/home/hduser/Pig/author-data'  USING PigStorage(',')  AS  (author_id, name:chararray);
--dump author_data;
book_data =  LOAD  '/home/hduser/Pig/book-data'  USING PigStorage(',')  AS  (book_id, price:int, author_id);
--dump book_data;
f_auth = filter author_data by INDEXOF(name,'J',0) == 0;
--dump f_auth;
book_price = filter book_data by price>=200;
--dump book_price;
aut_book = join f_auth by $0, book_price by $2;
--dump aut_book;
aut_book = foreach aut_book generate $0, $1, $2, $3;
dump aut_book;
store aut_book into '/home/hduser/kalai';



