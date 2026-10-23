# Traffic Light Controller (Verilog)

This project is a traffic light controller for a junction with two roads, North-South (NS) and East-West (EW). It is written in Verilog as a four-state Moore FSM, so the lights depend only on the current state. A counter inside the module decides how long each state lasts: the green light stays on for 10 clock cycles and the yellow light for 3 clock cycles. Both values are set by the parameters `GREEN_TIME` and `YELLOW_TIME`.

## States

| State | Code | NS light | EW light | Duration | Next state |
|---|---|---|---|---|---|
| S0 | `00` | Green | Red | 10 cycles (`GREEN_TIME`) | S1 |
| S1 | `01` | Yellow | Red | 3 cycles (`YELLOW_TIME`) | S2 |
| S2 | `10` | Red | Green | 10 cycles (`GREEN_TIME`) | S3 |
| S3 | `11` | Red | Yellow | 3 cycles (`YELLOW_TIME`) | S0 |

One full cycle takes 10 + 3 + 10 + 3 = 26 clock cycles. The counter resets to 0 every time the state changes.

**Reset:** `reset` is active-high and asynchronous. It puts the FSM in S0 (NS green, EW red) and clears the counter.

## Inputs and Outputs

Module `traffic_light_controller`:

| Port | Direction | Description |
|---|---|---|
| `clk` | Input | Clock; state and counter update on the rising edge |
| `reset` | Input | Active-high asynchronous reset to S0 |
| `NS_R`, `NS_Y`, `NS_G` | Output | North-South red, yellow, green |
| `EW_R`, `EW_Y`, `EW_G` | Output | East-West red, yellow, green |

## File Structure

```text
Traffic-Light-Controller-Verilog/
├── rtl/traffic_light_controller.v      # FSM design
├── tb/traffic_light_controller_tb.v    # testbench (10 ns clock, reset for 20 ns, then runs 600 ns)
├── state_diagram.jpeg
├── state_transition_table.jpeg
├── output_table.jpeg
├── traffic_light_controller.jpeg
├── LICENSE
└── README.md
```

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
