gate_data =  LOAD  '/home/hduser/Pig/gateway'  USING PigStorage('\t')  AS  (gateway:chararray, suc:int);
--dump gate_data;
web_data =  LOAD  '/home/hduser/Pig/weblog'  USING PigStorage('\t')  AS  (name:chararray, gateway:chararray, time);
--dump gate_data;
web_data = foreach web_data generate $0, $1;
--dump web_data;
gate_web = join gate_data by $0 , web_data by $1;
--dump gate_web;
gate_web = foreach gate_web generate $2, $0 as gate, $1 as success;
--dump gate_web; 
grp = group gate_web by $0;
--dump grp;
grp_avg = foreach grp generate $0, gate_web.gate, AVG(gate_web.success) as average;
--dump grp_avg;
grp_fil = filter grp_avg by average>90;
dump grp_fil;


