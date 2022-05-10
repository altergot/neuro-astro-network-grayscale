
# Neuro-astro network model

Here we propose a computational model of coloured memory in the spiking neural network accompanied by astrocytes.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- MATLAB ≥R2018b
- Statistics Toolbox
- Image Processing Toolbox
- The minimum required amount of RAM is 16 GB

### Installing

Clone repo:
```
git clone https://github.com/altergot/neuro-astro-network-grayscale.git
```

### Running the experiment

To run the default experiment execute `main.m`

Default experiment consists of 1 image at the learning stage:

![Julia](/images/Julia.jpg "Julia")

Next, at the testing stage, the model is applied to 4 images:
- training image with 80% Gaussian noise
- training image with 40% "Salt and Pepper" noise 
- spatial uniform noise
- another photo

The simulation model time is 1.9 seconds in the training and 0.7 seconds in each test. The time step is 0.0001 seconds.
The program run time for default parameters is around 1.5 hours.

### Results

The following results are presented at the end of the simulation:

1. Learning process: input signal, the average frequency of neural spikes during training, the concentration of calcium in the astrocytic layer at the time of presentation of the test images

![training](/results/Training.png "Training")
 
2. Test patterns and their corresponding neuron frequencies

![response](/results/Test.png "Test")

3. PSNR metric of a recalled pattern compared to training item

PSNR of recalled pattern for images:

 <table>
        </tr>
        <tr style="text-align: center;">
            <td>test image</td>
            <td>PSNR</td>
        </tr>
        <tr style="text-align: center;">
            <td>noisy training image with 80% Gaussian noise</td>
            <td>17.5825</td>
        </tr>
        <tr style="text-align: center;">
            <td>noisy training image with 40% "Salt and Pepper" noise</td>
            <td>16.8161</td>
        </tr>
        <tr style="text-align: center;">
            <td>another photo</td>
            <td>8.4843</td>
        </tr>
        <tr style="text-align: center;">
            <td>spatial uniform noise</td>
            <td>6.9498</td>
        </tr>
    </table>

### Parameters

File model_parameters.m consists of multiple parameter sections described in the paper:
- Timeline
- Experiment
- Applied pattern current
- Runge-Kutta steps
- Network size
- Initial conditions
- Neuron model
- Synaptic connections
- Astrocyte model
- PSNR metric

## Authors

* **Yulia Tsybina** - *Implementation* - [altergot](https://github.com/altergot)
* **Mikhail Krivonosov** - *Implementation* - [mike_live](https://github.com/mike_live)
* **Innokentiy Kastalskiy** - *Biological model constructing*
* **Susan Gordleeva** - *Biological model constructing*
* **Victor Kazantsev** - *Project vision*


## Cite

Astrocytes mediate analogous memory in a multi-layer neuron–astrocyte network
Yuliya A. Tsybina, Innokentiy A. Kastalskiy, Mikhail I. Krivonosov, Alexey Zaikin, Victor B. Kazantsev, Alexander N. Gorban and Susanna Yu. Gordleeva
https://doi.org/10.1007/s00521-022-06936-9

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
