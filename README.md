# MIPS Single-Cycle Processor — RTL Design & Verification

A fully functional, single-cycle MIPS microprocessor designed at the Register-Transfer Level (RTL) using structural VHDL and verified via the Xilinx Vivado Design Suite. Developed as a hardware architecture capstone at Florida Tech, this processor implements a fully decoupled datapath and control unit to execute a targeted 10-instruction subset of the MIPS ISA completely within a single clock cycle.

---

## 🏛️ System Architecture & Hardware Components

The design follows a strict non-pipelined microarchitecture where instruction fetching, decoding, register file access, ALU execution, and data memory operations resolve synchronously before the next rising clock edge.

### 📋 Supported Instruction Set Architecture (ISA)
The hardware natively decodes and executes a subset of 10 core MIPS instructions, tracking data routing across three distinct instruction formats:
* **Arithmetic / Logical (R-Type):** `add`, `sub`, `and`, `or`, `slt`
* **Immediate (I-Type):** `addi` (Arithmetic), `lw`, `sw` (Memory Reference)
* **Control Transfer:** `beq` (Conditional Branching), `j` (Unconditional Jump)

### 🧩 Structural Component Breakdown
The entire system architecture is built modularly by instantiating and structurally wiring **11 custom VHDL sub-components** inside the top-level entity (`mips_single_cycle_struct.vhd`):

* **`pc_register.vhd`**: A 32-bit synchronous register managing program counter address transitions.
* **`im_4byte_wide.vhd`**: A byte-addressable instruction memory module initialized at code segments base address `0x00400000`.
* **`regfile.vhd`**: A dual-read, single-write synchronous 32x32-bit register file handling operands execution dynamically.
* **`mips_cu_behave.vhd`**: The main behavioral control unit mapping opcodes (`Instr[31:26]`) directly to system routing lines (`RegDst`, `ALUSrc`, `MemtoReg`, `RegWrite`, `MemRead`, `MemWrite`, `Branch`, `Jump`).
* **`alu_controller.vhd`**: Combines a 2-bit ALUOp signal from the main control unit with instruction function codes (`funct` fields `Instr[5:0]`) to route 4-bit ALU control vectors.
* **`alu.vhd`**: The core execution engine performing operational tasks and generating a `Zero` flag used to resolve branching assertions.
* **`dm_4byte_wide.vhd`**: High-performance data memory subsystem maintaining data segment properties mapped starting at address `0x10010000`.
* **`sign_extend.vhd`**: Performs 16-bit to 32-bit sign extension for immediate parameters.
* **Adders & Shifters**: Houses standalone structural execution modules (`adder_first.vhd`, `adder_second.vhd`, `first_shift_left_2.vhd`, `second_shift_left_2.vhd`) to compute target addresses for sequential jumps and PC branching parameters in parallel.

---

## 🚀 Key Engineering & Digital Design Solutions

* **Structural VHDL Modeling**: Avoided flat monolithic behavioral tracking by designing modular, compilable individual hardware components tied together dynamically via port-mapping schemas.
* **MIPS Memory Map Alignment**: Synced internal VHDL addressing limits perfectly to replicate a genuine production memory alignment layout ($PC_0 = \text{0x00400000}$ for code segments and $\text{0x10010000}$ for static data limits).
* **Glitch-Free Verification Matrix**: Proved hardware optimization correctness by running custom assembly routines natively within the MARS IDE, extracting expected system memory hexadecimal output dumps, and verifying that the synthesizable RTL waves inside Vivado match bit-for-bit.

---

## 🛠️ Tech Stack & Tools
* **Hardware Description Language:** VHDL
* **EDA Synthesis & Simulation Tool:** Xilinx Vivado Design Suite
* **Target Architecture:** MIPS32 ISA (10-Instruction Core Subset)
* **Cross-Verification Tools:** MARS (MIPS Assembler and Runtime Simulator)

---

## 📂 Repository Layout
* **`/src`**: Core VHDL hardware design files containing the individual component layout files and structurally mapped modules.
* **`/sim`**: Simulation files and testbenches (`mips_single_cycle_tb.vhd`) utilized to assert timing validity over clock cycles.

---

## 📊 Verification & Simulation Results

To validate the behavioral accuracy of the RTL design, the processor's datapath was benchmarked using custom assembly test programs and cross-verified via hardware behavioral wave simulations in Xilinx Vivado alongside the MARS MIPS simulator environment.

### 1. Hardware RTL Simulation (Vivado)
The waveform profiles below illustrate execution correctness, sequencing through instruction fetches, programmatic multi-cycle branching, and accurate data synchronization across memory buses:

#### Core System Testbench & Instruction Bus
![MIPS Top Level Simulation](mips_top_level_simulation.png)

#### Register File Dynamic State Allocation
![Register File State Changes](register_file_state_changes.png)

#### Memory State Configurations
![Data Memory Waveforms](data_memory_waveforms.png)
![Instruction Memory Decode](instruction_memory_decode.png)

---

### 2. Assembly Target Cross-Verification (MARS)
The core logic blocks were validated using an exact architectural reference map to track memory segment states, ensuring pipeline hardware behaviors precisely follow MIPS ISA constraints.

![MARS Assembly Validation](mars_assembly_validation.png)

---

## ⚙️ How to View & Simulate in Vivado

### Prerequisites
* Xilinx Vivado Design Suite (2020.1 or newer recommended)

### Loading the Project
1. Clone the repository:
   ```bash
   git clone [https://github.com/liamprogulske/MIPS-Single-Cycle-Processor.git](https://github.com/liamprogulske/MIPS-Single-Cycle-Processor.git)
   ```
2. Open Vivado, select Open Project, and target your `.xpr` file

3. Click **Run Simulation** under the Vivado Flow Navigator to spin up the behavioral simulation waveforms and inspect data routing.
