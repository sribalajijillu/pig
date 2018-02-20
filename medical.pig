medical_data =  LOAD  '/home/hduser/Pig/medical'  USING PigStorage('\t')  AS  (name:chararray, dept, sal:int);
--dump medical_data;
medical_data = foreach medical_data generate $0, $2 as salary;
--dump medical_data;
grp = group medical_data by name;
--dump grp;
avgsal = foreach grp generate $0, AVG(medical_data.salary);
dump avgsal;




