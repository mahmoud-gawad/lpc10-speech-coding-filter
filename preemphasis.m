function [speechpreemphasis]=preemphasis(speech)
pre_emp_num = [1 -0.98]; 
pre_emp_den = 1; 
speechpreemphasis = filter(pre_emp_num,pre_emp_den,speech);
end