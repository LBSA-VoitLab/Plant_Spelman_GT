clear
  
 % initial conditions 
x0 = [1  1  1  1  1  1  1  4.9/6 ...
      1   4.9/6   4.9/6   4.9/6   1  0.475 ...
     0.475  4.9/6   4.9/6   0.475   0.475];









%iMonte = simulation set for 10 itterations ( this can be changed to more
%or less itterations)
%open struc in workspace to see values for as4, g2, and corresponding SSEs
% array fields = parameters SSEFe SSEZn
% parameters column = (as4, g2) 
%SSE columns =  (SSE on time 10, SSE time 13)
for iMonte = 1:10
    %Parameter Values; 
    Par=[1; 1; 1; 0.0038;   0.01 ;  14 ;  20  ;  3	;  2;  0.08;  4	;   0.5  ;     0.1;	 1;	 10;  0.1;   2;	 0;   0; 	 1; 	 1; 1; 	 2.5; 	 0.1;  	 0.1;  	 4;    0.1;          0.1;   			 0.1;     0.1;   0.1; 		 3;  -0.3; 2;  -0.3; 1;  1; ];
    %Randomize parameters as4 between 5 and 25 and g2 between -1 and 0; 
    a= 5;
    b= 25;
    as4 = (b-a).*rand(1) + a;
    Par(6)=as4;
    c= -1;
    d= 0;
    g2 =  (d-c).*rand(1) + c;
    Par(33)= g2;
    
    
    tic
    tspan = 7:13;
    [t,x] = ode45(@PlantDifEqlf,tspan,x0',[],Par);
    toc %26s
   

    for t1= 0:1:15
        % Fe sum in biomass
        Fe_biomass = x(:,8)  + x(:,10) + x(:,11) + x(:,12) + x(:,16) + x(:,17);
        % Zn sum in biomass
        Zn_biomass = sum(x(:,[14 15 18 19]),2);
        
        %SSE calculation for Fe at time 10 
        SSEFe10 = (9.789573 - Fe_biomass(4))^2;
        %SSE calculation for Fe at time 13 
        SSEFe13 = (19.12629 - Fe_biomass(7))^2 ;
        %SSE calculation for Zn at time 10 
        SSEZn10 =(2.814216 - Zn_biomass(4))^2 ;
        %SSE calculation for Zn at time 13 
        SSEZn13=(18.3426 - Zn_biomass(7))^2;
        
        %Figures: Post- Xylem Biomass ( can change to display state-variable plots )
        figure(1)
        plot(t,Fe_biomass)
        xlabel('time')
        ylabel('Fe Biomass')
        
        figure(2)
        plot(t, Zn_biomass)
        xlabel('time')
        ylabel('Zn_biomass')
    end
    
    
    
%prints as4 and g2 parameters with corresponding SSe values 
struct(iMonte).parameters=[as4 g2];
struct(iMonte).SSEFe= [SSEFe10 SSEFe13];
struct(iMonte).SSEZn=[SSEZn10 SSEZn13];
end  




