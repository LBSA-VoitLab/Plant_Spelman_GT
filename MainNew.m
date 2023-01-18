clear

% param
Par=[1; 1; 1; 0.0038;   0.01 ;  14 ;  20  ;  3	;  2;  0.08;  4	;   0.5  ;     0.1;	 1;	 10;  0.1;   2;	 0;   0; 	 1; 	 1; 1; 	 2.5; 	 0.1;  	 0.1;  	 4;    0.1;          0.1;   			 0.1;     0.1;   0.1; 		 3;  -0.3; 2;  -0.3; 1;  1; ];



% For a random set of parameters do this:

% Par=rand(37,1); % rand generates random numbers between 0 and 1. So, you need to multiply by the max value of each parameter

% Par=(rand(37,1)+.5).*OriginalPar; % this line changes the original parameters from 50% to 150%
% CalcOfSSE(Par)
  
 % initial conditions 
x0 = [1  1  1  1  1  1  1  4.9/6 ...
      1   4.9/6   4.9/6   4.9/6   1  0.475 ...
     0.475  4.9/6   4.9/6   0.475   0.475];

tic
tspan = 7:13; 
[t,x] = ode45(@PlantDifEqlf,tspan,x0',[],Par); 
toc %26s

% Fe_biomass = zeros(15,1);
% Zn_biomass = zeros(15,1);

for t1= 0:1:15
%     Fe_biomass(t1) = x(t1,8)  + x(t1,10) + x(t1,11) + x(t1,12) + x(t1,16) + x(t1,17);
%     Zn_biomass(t1) = x(t1,14) + x(t1,15) + x(t1,18) + x(t1,19);
% end

Fe_biomass = x(:,8)  + x(:,10) + x(:,11) + x(:,12) + x(:,16) + x(:,17);
Zn_biomass = sum(x(:,[14 15 18 19]),2);

%Figures: Post- Xylem Biomass ( can change to display state-variable plots ) 

figure(2)
plot(t,Fe_biomass)
xlabel('time')
ylabel('Fe Biomass')

figure(3)
plot(t, Zn_biomass)
xlabel('time')
ylabel('Zn_biomass')


end  
function dxdt = PlantDifEqlf(t,x,p)

% param;
Kan = p(1); 
atwbc19 = p(2);
FRD3 = p(3);
as1 = p(4);  
as2 = p(5); 
as4 = p(6); 
as6 = p(7) ; 	
a1_3= p(8); 	
a1_5 = p(9); 	  	 
a2_0 = p(10); 
a2_7= p(11); 
a2_14=p(12) ;    
a3_1= p(13);   					
a3_8 = p(14); 				
a4_9 = p(15); 
a5_1= p(16);  
a5_11= p(17); 		  
a6_12= p(18); 	 
a7_13= p(19); 	
a7_2 = p(20); 				
a8_9 = p(21); 							 										
a8_15 = p(22); 							
a9_8 = p(23); 	
a10_11 = p(24);  	
a10_10p = p(25);  	
a11_10 = p(26);   
a11_16 = p(27);         
a12_13 = p(28);   			
a13_12 = p(29);    
a13_17 = p(30);  
a14_18 = p(31); 
g1 = p(32); 
g2 = p(33);
g3 = p(34); 
g4 = p(35);
S1 = p(36); 
S2 = p(37); 

%Fluxes:
dxdt = zeros (19,1);
%==========================
VS1 = as1 * S1 * (x(8) +  x(10)+ x(16) + x(17))^g1;
V1_3 = a1_3 * x(1) * x(4);
V3_1 = a3_1 * x(3);
V1_5 = a1_5 * x(1) * x(6);
V5_1 = a5_1 *x(5);
% ==========================
VS4 = as4 * (1+ 2.5 * x(13))^g2;
V2_0 = a2_0 * (1+ (x(14) + x(15) + x(18) + x(19)))^g3;
V2_7 = a2_7 * x(2) * x(6);
V7_2 = a7_2 * x(7);
V2_14 = a2_14 * x(2);
% ==========================
V3_4 = V3_1;
V4_3 = V1_3;
V3_8 = a3_8 * x(3)* (Kan);
% ==========================
VS6 = as6 * (1+ x(9)/ 0.01)^g4 ;
V4_9 = a4_9 * x(4)  * FRD3;
% ==========================
V5_6 = V5_1;
V5_11 = a5_11 * x(5) * (atwbc19); 
% ==========================
VS2 = as2* S2 * (x(8) + x(10)  + x(16) + x(17))^g1;
V6_5 = V1_5;
V6_7 = V2_7;
V6_12 = a6_12 * x(6) * (atwbc19);
% ==========================
V7_6 = V7_2;
V7_13 = a7_13 * x(7) * (atwbc19);  
% ==========================
V8_9 = a8_9 * x(8);
V8_10 = V8_9;
V8_15 = a8_15 * x(8);
% ==========================
V9_8 = a9_8 * x(9) * x(10);
% ==========================
V10_8 = V9_8;
V10_11 = a10_11 * x(10) * x(13);
V10_10p = a10_10p* x(10);
% ==========================
V11_10 = a11_10 * x(12);
V11_12 = V11_10;
V11_16 = a11_16 * x(12);
% ==========================
V12_11 = V10_11;
V12_13 = a12_13 * x(13) * x(15);
% ==========================
V13_12 = a13_12 * x(14);
V13_14 = V13_12;
V13_17 = a13_17 * x(14);
% ==========================
V14_13 = V12_13;
V14_18 = a14_18 * x(15);
% ==========================

    dxdt(1) = VS1   - V1_3 + V3_1 - V1_5 + V5_1;
    dxdt(2) = VS2 - V2_7 + V7_2 - V2_14 - V2_0;
    dxdt(3) = V1_3 - V3_1 - V3_8;
    dxdt(4) = VS4 + V3_4 - V4_3 - V4_9 ;
    dxdt(5) = V1_5  - V5_1 - V5_11;
    dxdt(6) = VS6 + V5_6 - V6_5  +  V7_6 - V6_7 - V6_12;
    dxdt(7) = V2_7 - V7_2  - V7_13;
    dxdt(8) = V3_8 - V8_9 + V9_8 - V8_15;
    dxdt(9) = V4_9 + V8_9 - V9_8 ;
    dxdt(10)= V8_10 - V10_8 - V10_11 + V11_10   - V10_10p ;
    dxdt(11)= V10_10p ;
    dxdt(12)= V5_11 + V10_11 - V11_10 - V11_16;
    dxdt(13)= V6_12 + V11_12 - V12_11 - V12_13 + V13_12;
    dxdt(14)= V7_13 + V12_13 - V13_12 - V13_17;
    dxdt(15)= V2_14 + V13_14 - V14_13 - V14_18;
    dxdt(16)= V8_15;
    dxdt(17)= V11_16;
    dxdt(18)= V13_17;
    dxdt(19)= V14_18;
  
end
    

