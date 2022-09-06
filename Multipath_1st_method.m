L = 1000; 
N = 1;

h = randn(L,N) + 1i*randn(L,N);
Power = exp(-0.5*[0:L-1].^2)';
h = abs(h).*Power;

H = zeros(L,L);
i = 1;
z = 1;

for n=1:L                 
    for j = i:-1:1        
        H(n,z) = h(j);    
        z=z+1;            
    end           
    z=1;          
    i=i+1;        
end

inversed_H = inv(H); 
BER = [];
BER_Temp = [];
Eb = 1; 
No = [5 3 2 1 0.5 0.3 0.1 0.05 0.01 0.005 0.001]; 
for var = No
    N = sqrt(var/2)*randn(L,1);   
    for m = 1:10                  
                                  
        x = randi([0,1],1,L);     
        x = (x * 2)-1 ;            
        y = H*x' + N;             
        recieved_x = inversed_H*y; 
        
        D = zeros(size(recieved_x));  
                                      
        for k = 1:L
            if recieved_x(k) <= 0  
                D(k) = -1;
            else 
                D(k) = 1;          
            end
        end
        
        n = 0;            
        for k = 1:L
            if D(k) ~= x(k) 
                n = n+1;
            end
        end
        
        BER_Temp = [BER_Temp n/L];   
    end
    
    BER = [BER mean(BER_Temp)];   
    BER_Temp = [];  
end

figure;
 subplot(2,1,1); plot(x); title("tx")  
 subplot(2,1,2); plot(recieved_x); title("rx")  
figure; 
 plot(Eb./No , BER); title("BER vs Eb./No")
xlim([0 10])