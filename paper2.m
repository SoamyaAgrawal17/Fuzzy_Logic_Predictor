% 3 decision makers ,5 criteria, 5 alternatives
LT1=[0.6,0.7,0.7,0.8,0.9,0.5,0.7,0.7,0.9,1];
LT2=[0.95,1,1,1,0.9,0.9,1,1,1,1];
LT3=[0.8,0.9,0.9,0.95,0.9,0.7,0.9,0.9,1,1];

%decision matrix 5 alternatives * 5 criteria
decisionMatrix1= [LT1 LT1 LT3 LT3 LT3; LT3 LT2 LT2 LT3 LT2;LT2 LT2 LT2 LT2 LT3;LT3 LT3 LT1 LT3 LT3;LT1 LT1 LT1 LT1 LT1];
decisionMatrix2= [LT1 LT1 LT3 LT3 LT3; LT3 LT2 LT2 LT2 LT2;LT2 LT3 LT2 LT2 LT2;LT3 LT3 LT1 LT3 LT3;LT1 LT3 LT1 LT1 LT1];
decisionMatrix3= [LT1 LT2 LT3 LT3 LT3; LT3 LT2 LT2 LT2 LT2;LT3 LT3 LT3 LT2 LT3;LT3 LT1 LT3 LT3 LT2;LT1 LT3 LT1 LT3 LT1];

%Weight of criteria
weight1=[LT3 LT2 LT2 LT3 LT3];
weight2=[LT3 LT2 LT2 LT3 LT3];
weight3=[LT3 LT2 LT3 LT3 LT3];

%tau values
tau=[0.2429 0.5142 0.2429];

%collective value of alternative and criteria
decisionMatrix = tau(1)*decisionMatrix1 + tau(2)*decisionMatrix2 + tau(3)*decisionMatrix3;

%need to find minimum for elements that are multiple of 5.
for c = 1:50
    for r = 1:5
        
        if mod(c,5)==0
        decisionMatrix(r,c,1) = min([decisionMatrix1(r,c,1) decisionMatrix2(r,c,1), decisionMatrix3(r,c,1)]);
        end
        
    end
end

%collective value of weight for criteria.
weight=tau(1)*weight1+tau(2)*weight2+tau(3)*weight3;

%need to find minimum for elements that are multiple of 5.
for c = 1:50
    for r = 1:1
        
        if mod(c,5)==0
        weight(r,c,1) = min([weight1(r,c,1) weight2(r,c,1), weight3(r,c,1)]);
        end
        
    end
end


%signedDistanceBeforeMatrix

w1=weight(1,1:10,1);
w2=weight(1,11:20,1);
w3=weight(1,21:30,1);
w4=weight(1,31:40,1);
w5=weight(1,41:50,1);

weightCrossDecision=[w1 w2 w3 w4 w5 ;w1 w2 w3 w4 w5 ;w1 w2 w3 w4 w5 ;w1 w2 w3 w4 w5 ;w1 w2 w3 w4 w5];

%we need to multiply first weight with decision matrix
distance=weightCrossDecision.*decisionMatrix;

%change the multiple of 5 in distance matrix
for c = 1:50
    for r = 1:5
        
        if mod(c,5)==0
        distance(r,c) = min([weightCrossDecision(r,c),decisionMatrix(r,c)]);
        end
    end
end

%computing distances
distances=zeros(5,5);

for c = 1:5
    for r = 1:5
       distances(r,c)=signedDistance(distance(r,1+(c-1)*10),distance(r,2+(c-1)*10),distance(r,3+(c-1)*10),distance(r,4+(c-1)*10),distance(r,5+(c-1)*10),distance(r,6+(c-1)*10),distance(r,7+(c-1)*10),distance(r,8+(c-1)*10),distance(r,9+(c-1)*10),distance(r,10+(c-1)*10));
    end
end

%make concordance and discordance set
x=-1;
concordance=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];
x=-2;
concordance(:,:,2)=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];
x=-3;
concordance(:,:,3)=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];
x=-4;
concordance(:,:,4)=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];
x=-5;
concordance(:,:,5)=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];


k=1;

for c = 1:5
    for r = 1:5
        for k=1:5
            
            if  distances(r,k) - distances(c,k) >= 0
                    concordance(r,c,k)=-1*concordance(r,c,k);
            elseif (abs(distances(r,k) - distances(c,k) ) < 0.00000000001)
                    concordance(r,c,k)=-1*concordance(r,c,k);

            
            end
        end
    end
end

for c = 1:5
    for r = 1:5
        for k=1:5
            if  concordance(r,c,k)<0
                    concordance(r,c,k)=0;
            end
            
            if r==c
                concordance(r,c,k)=0;
            end
        end
    end
end
discordance=concordance;

for c = 1:5
    for r = 1:5
        for k=1:5
            
            
            if  concordance(r,c,k)==0
                discordance(r,c,k)=k;
            
            else  
                discordance(r,c,k)=0;
            
            end
            
            if r==c
                discordance(r,c,k)=0;
            end
        end
    end
end
  

%concordance index matrix
x=0;
concordanceIndex=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];

concordanceIndex(:,:,2)=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];
x=0;
concordanceIndex(:,:,3)=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];
x=0;
concordanceIndex(:,:,4)=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];
x=0;
concordanceIndex(:,:,5)=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];
x=0;
concordanceIndex(:,:,6)=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];
x=0;
concordanceIndex(:,:,7)=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];
x=0;
concordanceIndex(:,:,8)=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];
x=0;
concordanceIndex(:,:,9)=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];
x=0;
concordanceIndex(:,:,10)=[x x x x x; x x x x x; x x x x x; x x x x x; x x x x x];

%10 coordinates of weight after adding them up.

weightAdded=w1+w2+w3+w4+w5;
weightAdded(5)=min([w1(5),w2(5),w3(5),w4(5),w5(5)]);
weightAdded(10)=min([w1(10),w2(10),w3(10),w4(10),w5(10)]);
weightAddedf=weightAdded;
weightAdded(4)=weightAddedf(1);
weightAdded(3)=weightAddedf(2);
weightAdded(2)=weightAddedf(3);
weightAdded(1)=weightAddedf(4);
weightAdded(9)=weightAddedf(6);
weightAdded(8)=weightAddedf(7);
weightAdded(7)=weightAddedf(8);
weightAdded(6)=weightAddedf(9);


for c = 1:5
    for r = 1:5
      if ne(r,c)
           for j=1:5
                    if concordance(r,c,j)==1
                        for k=1:10
                         concordanceIndex(r,c,k)=concordanceIndex(r,c,k)+w1(k);
                        end
                    end
                    if concordance(r,c,j)==2
                        for k=1:10
                         concordanceIndex(r,c,k)=concordanceIndex(r,c,k)+w2(k);
                        end
                    end
                    if concordance(r,c,j)==3
                        for k=1:10
                         concordanceIndex(r,c,k)=concordanceIndex(r,c,k)+w3(k);
                        end
                    end
                    if concordance(r,c,j)==4
                        for k=1:10
                         concordanceIndex(r,c,k)=concordanceIndex(r,c,k)+w4(k);
                        end
                    end
                    if concordance(r,c,j)==5
                        for k=1:10
                         concordanceIndex(r,c,k)=concordanceIndex(r,c,k)+w5(k);
                        end
                    end
          end
      end
    end
end

for c = 1:5
    for r = 1:5
        
         for k=1:10
            concordanceIndex(r,c,k)=concordanceIndex(r,c,k)/weightAdded(k);
            if k==5
                concordanceIndex(r,c,k)=0.9;
            end
            if k==10
                concordanceIndex(r,c,k)=1;
            end
         end
         
        
    end
end

%distance concoradance
distanceConcordance=zeros(5,5);

for c = 1:5
    for r = 1:5
        if ne(r,c)
        distanceConcordance(r,c)=signedDistance(concordanceIndex(r,c,1),concordanceIndex(r,c,2),concordanceIndex(r,c,3),concordanceIndex(r,c,4),concordanceIndex(r,c,5),concordanceIndex(r,c,6),concordanceIndex(r,c,7),concordanceIndex(r,c,8),concordanceIndex(r,c,9),concordanceIndex(r,c,10));
        end
   end
end

%disp(distanceConcordance);

%average concordance
averageConcordance=zeros(1,10);
for i=1:5
    for j=1:5
        
        for k=1:10
            averageConcordance(k)=averageConcordance(k)+concordanceIndex(i,j,k);
        end
        
    end
end

m=5;
value=m*(m-1);
for k=1:10
    averageConcordance(k)=averageConcordance(k)/value;
end

averageConcordance(5)=0.9;
averageConcordance(10)=1;

%average Concordance distance
averageConcordanceDistance=signedDistance(averageConcordance(1),averageConcordance(2),averageConcordance(3),averageConcordance(4),averageConcordance(5),averageConcordance(6),averageConcordance(7),averageConcordance(8),averageConcordance(9),averageConcordance(10));
%disp(averageConcordanceDistance);

%concordance outranking matrix G1 construction
g1=zeros(5,5);
for i=1:5
    for j=1:5
        if distanceConcordance(i,j)>=averageConcordanceDistance
            g1(i,j)=1;
        end
        
    end
end


%calculating euclidean distance
euclideanDistance = zeros(5,5,5);
for i=1:5
    for j=1:5
        for k=1:5
            parameter1=decisionMatrix(i,1+(k-1)*10:10+(k-1)*10);
            parameter2=decisionMatrix(j,1+(k-1)*10:10+(k-1)*10);
            
            if(k==1)
            euclideanDistance(i,j,k)=EDistance(w1,parameter1,parameter2);
            end
            if(k==2)
              euclideanDistance(i,j,k)=EDistance(w2,parameter1,parameter2);  
            end
            if(k==3)
            euclideanDistance(i,j,k)=EDistance(w3,parameter1,parameter2);
            end
            if(k==4)
              euclideanDistance(i,j,k)=EDistance(w4,parameter1,parameter2);  
            end
              if(k==5)
            euclideanDistance(i,j,k)=EDistance(w5,parameter1,parameter2);
              end
              
        end
    end
end


%discordance index
discordanceIndex=zeros(5,5);


for i=1:5
    for j=1:5
        if ne(i,j)
            maxn=0;
            maxd=0;
            for k=1:5
              if discordance(i,j,k)>0
                  if euclideanDistance(i,j,k)>maxn
                      maxn=euclideanDistance(i,j,k);
                      
                  end
              end
              if euclideanDistance(i,j,k)>maxd
                      maxd=euclideanDistance(i,j,k);
                      
              end
            end
            discordanceIndex(i,j)=maxn/maxd;
        end
    end
end

%disp(discordanceIndex);

%average discordance
averageDiscordance=0;
for i=1:5
    for j=1:5
        
        
            averageDiscordance=averageDiscordance+discordanceIndex(i,j);
        
        
    end
end

m=5;
value=m*(m-1);

    averageDiscordance=averageDiscordance/value;


%disp(averageDiscordance);

%discordance outranking matrix G2 construction
g2=zeros(5,5);
for i=1:5
    for j=1:5
        
        if discordanceIndex(i,j)<averageDiscordance
            g2(i,j)=1;
        end
        
    end
end
disp('start');
disp('g1');
disp(g1);
disp('g2');
disp(g2);

%intersection of g1 and g2
g=min(g1,g2);
disp('g');
disp(g);

%plot graph
%G=digraph(g);
%plot(G);


%algorithm-2 for linear ordering
netConcordance = zeros(5,10);
for i=1:5
    
    for j=1:5
        if ne(i,j)
            for k=1:10
        netConcordance(i,k)=netConcordance(i,k)-concordanceIndex(i,j,k);
                
            end
        end
    end;
        for j=1:5
            if ne(i,j)
                for k=1:10
                netConcordance(i,k)=netConcordance(i,k)-concordanceIndex(j,i,k);
                if k==5
                    netConcordance(i,k)=0.9;
                end
                if k==10
                    netConcordance(i,k)=1;
                end
                end
            end
        end;
end
%computing signed distances
signedDistanceComparison = zeros(1,5);
for i=1:5
    signedDistanceComparison(1,i)=signedDistance(netConcordance(i,1),netConcordance(i,2),netConcordance(i,3),netConcordance(i,4),netConcordance(i,5),netConcordance(i,6),netConcordance(i,7),netConcordance(i,8),netConcordance(i,9),netConcordance(i,10));
end
disp('algorithm-2');
disp(signedDistanceComparison);
disp('end');