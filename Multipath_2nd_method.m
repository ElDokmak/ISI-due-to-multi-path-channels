n=1000;
step=0.2; 
limit=20;
X= 2*randi([0,1],n,1) -1 ;
H=zeros(n,n);
    for j=1:n    
        h= randn(1,1)+1i*randn(1,1);
        u=j;
        while(u<=n)
            k=u-j+1;
            H(u,k)=h;
            u=u+1;
        end
    end

No=zeros(limit,1);
for i=0:(limit-1)
    if i==0
        No(1)=0;
    else    
    No(i+1)=No(i)+step;
    end
end

BER=zeros(limit,1);
for p=1:limit
    N=sqrt(No(p)/2)*randn(n,1);
    Y=H*X+N;
    i=2;
    X_dash=zeros(n,1);
    X_dash(1,1)=Y(1,1)/H(1,1);
    if X_dash(1,1)<0
        X_dash(1,1)=-1;
    else
        X_dash(1,1)=1;
    end
    
    sum=0;
   while i<(n+1) 
      j=1;
        while j<i
        sum=sum+H(i,j)*X_dash(j,1);
        j=j+1;
        end
      
        X_dash(i,1)=(Y(i,1)-sum)/H(i,i);
        if X_dash(i,1)<0
            X_dash(i,1)=-1;
        else
            X_dash(i,1)=1;
        end
    
        
        if real(Y(i,1))<0
            Y(i,1)=-abs(Y(i,1));
        else
            Y(i,1)=abs(Y(i,1));
        end
        if X_dash(i,1)~=X(i,1)
            BER(p)=BER(p)+1;
        end 
        sum=0;
        i=i+1;
   end
   BER(p)=BER(p)/n;
end

figure;
plot(1./No,BER)
title('BER and 1/No Relation')
xlabel('1/No')
ylabel('BER')
xlim([0 5]);
