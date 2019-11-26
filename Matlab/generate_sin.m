
clear all

close all

clc

N=2000;
t = [0:1:N-1];%输入范围0-90度，步长0.1度

x =2*pi*t/N;

y = round((sin(x)+1)* (2^15));

fid=fopen('sin.mif','wt');
fprintf(fid,'width=16;\n');
fprintf(fid,'depth =2048;\n');

fprintf(fid,'address_radix=uns;\n');

fprintf(fid,'data_radix=dec;\n');

fprintf(fid,'content begin\n');

c=0;

for j=1:N
    i=j-1;
    if y(j)>=2^16
        c=c+1;
        y(j)=2^16-1;
    end
    fprintf(fid,'%d:%d;\n',i,y(j));
end

fprintf(fid,'end;\n');

fclose(fid);

plot(y);

