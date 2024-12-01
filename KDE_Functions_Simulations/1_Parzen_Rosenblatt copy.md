  The program impliments the Parzen Rosenblatt Kernel smoother on an Multimodal distribution. 
  Aswell, performs bias variance ananlysis in the following steps: 
  
    1.) generate 150 samples from the population distribution 
    
    2.) evaluates the KDE on each sample at a given h bandwidth 
    
    3.) take the mean 150 KDE evaluations from 150 samples for each bandwidth 
    
    4.) evaluates and plots the totall bias and variance of the mean of the sample 
    evaluations for each bandwidth h 
    
    5.) evaluates the MSE and prints MSE (sum of totall bias and variance) to 
    suppliment visual plot  


  Example usages:
  the KDE evaluated on 1 sample at a variety of h values plotted with the true distribution
![alt text](https://github.com/Jacob-J-Richards/KDE_Functions_and_Simulations/blob/main/images/better.png))

  totall bias and variance of the KDE as a function of step size performed on 150 samples from distribution 
![alt text](https://github.com/Jacob-J-Richards/KDE_Functions_and_Simulations/blob/main/images/better4.png)

  Plot of mean of 150 KDE evaluations at h = 0.75 
![alt text](https://github.com/Jacob-J-Richards/KDE_Functions_and_Simulations/blob/main/images/better5.png)

