# APB Protocol Implementation in Verilog

This repository contains a Verilog-based implementation of the **Advanced Peripheral Bus (APB)** protocol. The project consists of an APB Master and APB Slave module that communicate using APB signaling.

## Features
- Implements a **two-state FSM** for both master and slave.
- Supports **read and write** operations with memory-mapped registers.
- Uses **handshaking signals** (`psel`, `penable`, `pready`) to ensure correct data transactions.
- **Clock generation logic** included for simulation and testing.

## Project Structure
## APB Master FSM States
- **IDLE**: Waits for the start signal.
- **SETUP**: Latches address and control signals.
- **ACCESS**: Transfers data based on `pwrite` signal.

## APB Slave FSM States
- **IDLE**: Waits for `psel` signal.
- **READ**: Fetches data from memory.
- **WRITE**: Writes received data to memory.

## Simulation & Testing
To simulate the design, use a Verilog simulator such as **ModelSim, VCS, or Icarus Verilog**.

### Steps to Run Simulation
1. **Clone the repository:**
   ```bash
   git clone https://github.com/Nilesh002/AMBA-APB-Protocol-Design.git
   cd apb_project

