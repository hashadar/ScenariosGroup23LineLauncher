l=[1,2,3,4,5,6,7,8,9,0];
s=[2,2,2,2,2,2,2,2,2,2];
x=zeros(10);
k=zeros(1);
z=zeros(1);
for i=1:10
    k=l(i)
    y=k.*s
    x(i,:)=y
end
