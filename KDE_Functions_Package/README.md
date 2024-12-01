
<h1 align="center"> KDE Functions </h1>

<h1 align="center"> Priestley-Chao  |  Parzen-Rosenblatt  |  Nadaraya-Watson </h1>

## Install:

    devtools::install_github("Jacob-J-Richards/KDE_Functions_Package")
    
    library(Kernel.Density.Estimators)

## Call Commands: 
    Priestley_Chao(user_data_x,user_data_y,user_input_h,user_input_arg)
    
    Parzen_Rosenblatt(user_data,user_input_h,user_input)
    
    Nadaraya_Watson(user_data_x,user_data_y,user_input_h,user_input_arg)
    

## Test Code:

    Priestley_Chao(seq(-3.14,3.14,by=.1),cos(seq(-3.14,3.14,by=.1)),1,seq(-3.14,3.14,by=.01))
    
    Parzen_Rosenblatt(rnorm(100),1,seq(-3,3,length.out=500)) 
    
    Nadaraya_Watson(seq(-3.14,3.14,by=.1),cos(seq(-3.14,3.14,by=.1)),1,seq(-3.14,3.14,by=.01))
