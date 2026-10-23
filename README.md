## FSM Design

The traffic light controller is implemented using a four-state Moore Finite State Machine (FSM).

### State Diagram

![Moore FSM State Diagram](state_diagram.jpeg)

### State Transition Table

![State Transition Table](state_transition_table.jpeg)

### Output Table

![Moore FSM Output Table](output_table.jpeg)

## How to Simulate

```sh
iverilog -o traffic_light_controller.vvp rtl/traffic_light_controller.v tb/traffic_light_controller_tb.v
vvp traffic_light_controller.vvp      # writes traffic_light_controller.vcd
gtkwave traffic_light_controller.vcd
```
