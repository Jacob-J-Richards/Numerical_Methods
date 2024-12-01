This project implements the Priestley-Chao Estimator, a nonparametric method used to approximate the probability density function (PDF) from which a dataset is sampled. The implementation includes both a base function and an alternative maximal function that refines the estimation procedure. The code is structured using S4 classes in R, offering modularity and clarity.
Key Features:

Estimator Class:
An S4 class, estimator, is defined to represent the Priestley-Chao estimator.
The class contains attributes such as:
        h: bandwidth parameter for smoothing.
        x and y: input data values.
        MPC: the main output, a set of Priestley-Chao estimates at specified input_argument values.
        max_xi: stores the maximal values of the PDF estimates in the alternative function.

Base Function:
        The PC.smoother method approximates the PDF based on the input data.
        It takes input values (x, y) and applies the Priestley-Chao formula, iterating over a set of input_argument values to compute the estimates (MPC).
        The method also orders the input data (x, y) before applying the estimator to ensure proper spacing between the points.
        The result is visualized using a plot, and the first five values of the input arguments and corresponding MPC estimates are printed.
        

    Example function call:

        phi<- rnorm(100)
        noise <- rnorm(100,0,1)
        gamma <- cos(3*phi) + 0.1*noise

        this is just cos(3x) with a little bit of randomness to see if the estimator can handle it

        base_object <- new("estimator", h = 1, x = phi, max_xi= numeric(), y = gamma, 
                           MPC = numeric(), input_argument = seq(-4, 4, length.out = 500))
        object <- PC.smoother(base_object)
        show(object)

the results of the estimator 
![1030-2](https://github.com/user-attachments/assets/3f33d476-5b2b-46d4-94d9-22d7c7d4bbdc)

you can see the estimator is not as good around x=0 because the noise coeficients were sampled from Noise ~ N(0,1)

the data set the estimator is evaluating on 
![1030-1](https://github.com/user-attachments/assets/149e0689-2f3a-4659-98f1-fbbb26ed6973)


Alternative Maximal Function:

The PC.smoother.maximal method extends the base function by dynamically generating new data points (x, y) sampled from a normal distribution and updating the bandwidth h.
This function applies the same Priestley-Chao smoothing technique as the base function but operates with different data to explore the distribution behavior across multiple runs.

Finding Maximal MPC Values:

The find.max method runs the PC.smoother.maximal function 10,000 times to capture the maximal values of the MPC estimates.
After running the simulation, it computes and prints the mean and standard deviation of the maximal MPC values (max_xi).


Example function call sequence:

    maximal_object <- new("estimator", h = 1, x = numeric(), max_xi = numeric(), y = numeric(), 
                          MPC = numeric(), input_argument = seq(-4, 4, length.out = 500))
    find.max(maximal_object)


Simulation and Results:

Base Example:
An example dataset is generated using random values, and the base function is called to estimate the Priestley-Chao smoother.
The function outputs a plot of the estimated density over a specified input range and prints the first few values of the input argument and MPC estimates.

Optimization via Maximal Function:
The alternative function is run for 10,000 iterations, and the maximal MPC values are recorded.
The mean and standard deviation of these maximal values are calculated to give insights into the performance of the estimator over multiple trials.

Performance:
The time taken for the 10,000 simulations is measured and output, allowing for an evaluation of the computational efficiency of the method.

Conclusion:

This implementation demonstrates the utility of the Priestley-Chao estimator in approximating probability density functions. By running simulations to find the maximal output of the estimator, the project showcases how the method can be applied to optimize the estimation process. The results provide a detailed exploration of how bandwidth (h) and input data affect the estimation accuracy, particularly when running large-scale simulations.
