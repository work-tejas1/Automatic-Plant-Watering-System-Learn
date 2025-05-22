# Automatic-Plant-Watering-System

## I. Introduction to the Problem and the Solution
The Automatic Plant Watering System is an Arduino-based automated system designed to monitor and maintain the health of your plants. By integrating sensors and automated controls, this system ensures your plants receive the right amount of water at the right time, reducing the need for manual intervention and enhancing plant care.

The system monitors critical environmental factors such as soil moisture and humidity. When the soil moisture level falls below a certain threshold, the system automatically activates a water pump DC to hydrate the plants. This automation helps create a stable and optimal growing environment, promoting healthier and more robust plant growth.

The problem that necessitates the existence of the Automatic Plant Watering System is the challenge of effectively managing plant care. Traditional methods require constant vigilance and manual effort to ensure plants receive adequate water and live in a suitable environment. Inconsistent watering and fluctuating environmental conditions can lead to plant stress, poor growth, or even death.

The Automatic Plant Watering System addresses these issues by providing an automated and precise solution for plant care. The system uses sensors to continuously measure soil moisture levels and environmental conditions. By collecting and analyzing this data, it can automatically adjust the watering schedule, ensuring plants are always in an optimal state for growth. This not only saves time and effort for gardeners but also significantly improves the chances of plant survival and productivity.

## II. Hardware Design and Implementation Details
The Hardware designed using Proteus Software and implemented by components from below.

### Arduino UNO

- **Purpose**: To be used as the microcontroller

- **Purpose**: To measure the moisture level in the soil or growing medium.
- **Connection**: The soil moisture sensor is connected to the Arduino board via analog input pins. It helps determine whether the soil is too dry or has adequate moisture, ensuring your plants get the right amount of water.

### Temperature and Humidity Sensor (DHT 11)

- **Purpose**: To measure ambient temperature and humidity.
- **Connection**: The DHT series 11 is connected to the Arduino board through digital input/output pins. This sensor provides essential data about the surrounding environment, allowing you to adjust conditions to suit your plants' needs.


- **Purpose**: To automatically water the plants when the soil moisture level is low.
- **Connection**: The water pump is controlled by the Arduino through a relay module, which acts as a switch to turn the pump on and off.


- **Purpose**: To control the water pump by acting as a switch.
- **Connection**: Connected to the Arduino and the water pump. The Arduino sends a signal to the relay module to turn the pump on or off.



## III. Software Implementation Details

We use the Arduino IDE to flash the program into the arduino via USB type B cable. The program itself is fully written in AVR Assembly programming based on ATmega328p microcontroller, thus it is designed and tested on Arduino UNO. The Assembly code controls the components of the system individually which is DHT11, YL39 and MAX7219. Each of the components controlled to behave differently. The code controls MAX7219 as an actuator using SPI connection with Arduino to display the readings from DHT11 which shows the humidity & temperature, also to show whether the soil is dry or moist from the soil moisture sensor. The display itself is shown after every 5 seconds delay, the first 5 seconds shows the temps & humidity after that the display shows "dry" or "moist". When the system detects from soil moisture sensor the soil is dry, it will send a signal to (pin that connects to) the dc water pump water. This part of showing is looped through the program.


## IV. Test Results and Performance Evaluation
The project testing is done to ensure the components and modules used for the automatic plant watering system work properly. From the test results, we tested the system to read from the DHT11 and the dry or wet part. From the picture below, we can see that the LED is displaying the data properly. 



## V. Conclusion and Future Work
### Conclusion
The Automatic Plant Watering System is an ATMega328p based project that addresses the challenge of effectively managing plant care . By integrating sensors and automated controls, this system ensures plants receive the right amount of water at the right time, reducing the need for manual intervention and enhancing plant care. The system uses Arduino-based hardware components such as moisture sensors, temperature and humidity sensors, water pumps, LEDs, resistors, and relay modules to create a stable and optimal growing environment. The software implementation, written in AVR Assembly programming, controls the components individually and displays the readings on a MAX7219 display. The project has been tested and proven to work properly, accurately displaying the condition of the soil and environment. Overall, the Automatic Plant Watering System provides an automated and precise solution for plant care, saving time and effort for gardeners and significantly improving the chances of plant survival and productivity.

### Future Work
The system itself work properly but it always can be improved by having a proper delay between display or better yet using button to choose what to display. Other things to be improved is the analog reading of the soil sensor.

## How to use
1. Connects the hardware correctly by the diagram
2. Clone the repository 
3. Connect the arduino to your PC
4. Make sure it has successfully connected by checking COM port (Windows) or /dev/ttyUSB0 (Ubuntu)
5. Upload the code to the Arduino

## Contributors
- Tejas
