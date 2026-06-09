# Verilog Vending Machine FSM

A digital logic project that implements a **vending machine controller** using Verilog.  
The design is based on a finite state machine (FSM) and includes product selection, coin input, amount checking, product dispensing, inventory reduction, and change handling.

This project was developed independently as a logic circuit / Verilog project.

## Project Overview

The vending machine accepts different coin values, checks whether the selected product is available, verifies whether the inserted amount is enough, dispenses the selected product, and returns change when needed.

The controller is implemented using a 6-state FSM:

| State | Code | Description |
|---|---:|---|
| `IDLE` | `000` | Initial state. Resets total amount, product output, and change. |
| `AVAILABLE` | `001` | Checks whether the selected product is available in stock. |
| `WAIT_COIN` | `010` | Waits for coin input and adds the coin value to the total amount. |
| `CHECK_AMOUNT` | `011` | Checks whether the inserted amount is enough for the selected product. |
| `DISPENSE` | `100` | Dispenses the selected product and decreases its inventory. |
| `GIVE_CHANGE` | `101` | Handles returning change and resets the transaction. |

## Features

- Verilog implementation of a vending machine controller
- FSM-based design with 6 states
- 4 selectable products
- Product availability / inventory check
- Coin input handling
- Price checking logic
- Product dispensing logic
- Change calculation
- Testbench included for simulation
- Project report included as `circuit.pdf`

## Product Prices

| Product | Select Code | Price |
|---|---:|---:|
| Product A | `00` | 10 |
| Product B | `01` | 20 |
| Product C | `10` | 30 |
| Product D | `11` | 40 |

## Coin Encoding

| Coin Code | Value |
|---:|---:|
| `00` | 1 |
| `01` | 10 |
| `10` | 20 |
| `11` | 50 |

## Project Structure

```text
.
├── vendingmachine.v       # Main Verilog module for the vending machine FSM
├── vendingmachinetb.v     # Testbench for simulating the vending machine
├── circuit.pdf            # Project report and explanation
├── README.md              # Project documentation
└── .gitignore             # Git ignore rules for simulation/build files
```

## Main Module

The main module is defined in:

```text
vendingmachine.v
```

Module name:

```verilog
vending_machine
```

### Inputs

| Signal | Width | Description |
|---|---:|---|
| `clk` | 1 bit | Clock signal |
| `reset` | 1 bit | Resets the FSM to the initial state |
| `coin` | 2 bits | Encoded coin input |
| `select` | 2 bits | Selected product code |
| `vend` | 1 bit | Starts or confirms the vending operation |

### Outputs

| Signal | Width | Description |
|---|---:|---|
| `total` | 8 bits | Total inserted amount |
| `product` | 4 bits | Dispensed product code |
| `change` | 8 bits | Returned change amount |
| `state` | 3 bits | Current FSM state |

## How to Run the Simulation

You can simulate the project using any Verilog simulator such as **Icarus Verilog**, **ModelSim**, or **QuestaSim**.

### Option 1: Run with Icarus Verilog

Install Icarus Verilog, then run:

```bash
iverilog -o vending_machine_tb.out vendingmachine.v vendingmachinetb.v
vvp vending_machine_tb.out
```

### Option 2: Run with ModelSim / QuestaSim

```tcl
vlib work
vlog vendingmachine.v vendingmachinetb.v
vsim vending_machine_tb
run -all
```

## Testbench

The testbench file is:

```text
vendingmachinetb.v
```

The testbench:

- Generates a clock signal every 5 ns
- Applies reset
- Selects different products
- Inserts different coin values
- Triggers the `vend` signal
- Simulates multiple vending machine transactions

## Notes

- If the selected product inventory is zero, the controller returns to the initial flow instead of dispensing a product.
- The `vend` signal is used to start the operation and also to move from coin insertion to amount checking.
- The design focuses on FSM behavior and digital logic implementation.

## Suggested Repository Name

```text
Verilog-Vending-Machine-FSM
```

Alternative names:

```text
Vending-Machine-Verilog
Digital-Logic-Vending-Machine
FSM-Vending-Machine
```

## Author

Developed independently by **Iman Babajani**.

## License

This project is provided for educational purposes.
