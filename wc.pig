words =  LOAD  '/home/hduser/Pig/Textfile.txt'  USING TextLoader()  AS  (gateway:chararray);
--dump words;
word_sep = foreach words generate FLATTEN(TOKENIZE(gateway)) as word;
Lower = foreach word_sep generate LOWER(word) as low;
--dump Lower;
grp = group Lower by low;
--dump grp;
Word_count = foreach grp generate group, COUNT(Lower);
dump Word_count;


