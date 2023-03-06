1. Baseline Model
The file Metal uptake.plc contains the PLAS code for all “What-If” simulations. It shows first the ODEs, expressed in the format of influxes and effluxes associated with each pool, which is followed by the symbolic definition of these fluxes. The next section contains all initial values and parameter settings. The subsequent section contains alternative settings for the WBC19 mutant, Kan inhibition, etc. 
As an example, the first five lines of this section
Fe_init: 5.9 
Zn_init: 1.8

VS1 * 8
VS2 * 0.3
VS4 * 0.5
indicate the measured initial values for the WBC19 mutant and one set of compensatory changes to VS1, VS2, and VS4, with which the model must be adjusted to simulate this scenario. For instance, either VS1 or its rate as1 is to be multiplied by 8, etc. 
The final lines are definitions of Fe and Zn biomass, settings to model wild type (Kan =WBC = FRD3 = 1) or other scenarios, and the initial time, final time, and report interval.
The command 
!! Fe_biomass Zn_biomass
is PLAS syntax instruction the program only to show the results for biomass.
![image](https://user-images.githubusercontent.com/110258322/223244744-0d109ec4-fbac-45b6-8337-7c9b1933b950.png)
2. Baseline Model for Monte-Carlo Simulations
The file MC_Arabidopsis.plc contains an example of a Monte-Carlo simulation of the model in PLAS, where the two parameters as4 and g2 are randomized 1,000 times and the resulting residual errors are recorded. Specifically, the command
as4 = rand[20] +5  //14 
randomizes as4 between 5 and 25; the slashes and 14 contain a comment, reminding us that the baseline value in the model was set to 14.
Similarly, the command 
g2 = rand[1] - 1 //-.3
randomizes g2 between -1 and 0.
Other additional lines in the code direct PLAS to compute the sums of squared errors for Fe and Zn at times 10 and 13 in comparison with the measured values. Finally, the commands between 
count1 = 1
and 
![image](https://user-images.githubusercontent.com/110258322/223244803-985e21bd-ab7c-4f78-87a0-eb3847b44580.png)
end script
are PLAS syntax for executing the Monte-Carlo simulation.
After running the file by clicking            , the code is executed. Once completed, a window behind the code window shows the results in the form of a table:
![image](https://user-images.githubusercontent.com/110258322/223244840-596b1067-1b65-4891-8488-7e66db041960.png)
<img width="350" alt="image" src="https://user-images.githubusercontent.com/110258322/223245024-d54f2cb4-223b-4f6b-bbc1-4fac4ac45d58.png">
The entire table may be copied into Excel where, for instance, the sum of all four SSEs may be computed. The table is then sorted, e.g, by the total SSE. The initial part of the table of results is something like the following:![image](https://user-images.githubusercontent.com/110258322/223245080-d2bb7741-2f47-47f1-bcf5-6ac6ae9844d5.png)
<img width="468" alt="image" src="https://user-images.githubusercontent.com/110258322/223245137-522976a8-0c77-4456-8669-177eac93023a.png">
Of course, every simulation produces slightly different results, due to the random nature of the process. One may now plot, as an example, the different combinations of as4 and g2 that lead to very small SSE values, here defined as 2 times the optimal SSE. In this case, there is a clear, slightly curved relationship, and the settings of the model are roughly in the center of this line (14, -0.3). 
Looking at the end of the Excel table shows that many combinations of as4 and g2 yield much worse SSEs:
![image](https://user-images.githubusercontent.com/110258322/223245187-ef703556-2792-4cc1-8846-699ebc1bce4e.png)
<img width="205" alt="image" src="https://user-images.githubusercontent.com/110258322/223245286-3536209a-2106-4184-a758-b0df3b044265.png">
While as4 and g2 are still within the boundaries permitted by the simulation settings, the worst outcome of this particular simulation is an SSE of over 85, which is about 3,600 times as high as the best solution among those found in this simulation. Thus, the individual parameters are quite sensitive, but if their values happen to be close to the relationship shown above, they permit some variability without loss of quality of fit.![image](https://user-images.githubusercontent.com/110258322/223245378-50ff9d1d-d869-4436-93d5-8f856d6dd0a0.png)
