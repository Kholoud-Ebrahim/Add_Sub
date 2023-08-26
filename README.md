# Add_Sub
A simple module which performs addition and subtraction operations.

## Add_Sub Block Diagram
![image](https://github.com/UserImages/user_images/blob/main/add_sub.PNG)

| Signal   |    Description                     | Direction| Width     |
|----------|------------------------------------|----------|-----------|
| clk      | system clock                       | input    | 1         |
| rst      | active high asynchronous reset     | input    | 1         |
| a        | The first signal of Add operation  | input    | WIDTH     |
| b        | The second signal of Add operation | input    | WIDTH     |
| x        | The first signal of Sub operation  | input    | WIDTH     |
| y        | The second signal of Sub operation | input    | WIDTH     |
| add      | The Addition Result                | output   | WIDTH + 1 |
| sub      | The Subtraction  Result            | output   | WIDTH + 1 |

## 1. UVM Based Testbench Architecture of Add_Sub_Basic
![image](https://github.com/UserImages/user_images/blob/main/add_sub_basic.PNG)

## 2. UVM Based Testbench Architecture of Add_Sub_With_Config_Object
![image](https://github.com/UserImages/user_images/blob/main/add_sub_config_object.PNG)
