# Computer-Architecture-Lab

## ARM-Based Simple Processor Design and Implementation

### Overview
This project involves the design and implementation of a simple processor based on the ARM architecture. The processor is capable of executing basic operations and is implemented using Verilog. The design process includes simulation, synthesis, and testing on an FPGA board. The project also explores various optimization techniques such as forwarding, hazard detection, cache implementation, and SRAM integration. For more information you can read the [Report](./report/ComputerArchitectureLabReport-810100165-810100129.pdf).

### Project Structure
The project is divided into several stages, each focusing on a specific aspect of the processor design:

1. **[IF Stage (Instruction Fetch)](./src/IF-stage/)**: This stage fetches instructions from memory and prepares them for decoding.
2. **[ID Stage (Instruction Decode)](./src/ID-stage/)**: This stage decodes the fetched instructions and prepares the necessary control signals.
3. **[EXE Stage (Execution)](./src/Exe-stage/)**: This stage performs arithmetic and logical operations using the ALU.
4. **[MEM Stage (Memory Access)](./src/Mem-stage/)**: This stage handles memory read and write operations, including interactions with SRAM.
5. **[WB Stage (Write Back)](./src/WB-stage/)**: This stage writes the results of operations back to the register file.
6. **[Hazard Unit](./src/hazard_unit.v)**: This unit detects and resolves data hazards in the pipeline.
7. **[Forwarding Unit](./src/forwarding_unit.v)**: This unit forwards data from later stages to earlier stages to avoid stalls.
8. **[SRAM Integration](./src/Mem-stage/sram_controller.v)**: This stage integrates SRAM into the memory system to simulate real-world memory accesses and manage data storage and retrieval efficiently.
9. **[Cache Implementation](./src/Mem-stage/cache_controller.v)**: This stage implements a cache memory to improve data access speed.

### Key Features
- **Pipeline Architecture**: The processor is designed with a 5-stage pipeline to improve instruction throughput.
- **Hazard Detection and Forwarding**: The processor includes a hazard detection unit and a forwarding unit to handle data dependencies and avoid pipeline stalls.
- **SRAM Integration**: SRAM is integrated into the memory system to simulate real-world memory accesses, providing a more realistic memory hierarchy.
- **Cache Memory**: A two-way set-associative cache is implemented to reduce memory access latency.
- **FPGA Implementation**: The processor is synthesized and tested on an FPGA board using Quartus II.

### Simulation and Testing
The processor is simulated using ModelSim to verify its functionality. A testbench is created to test individual modules and the entire processor. The final design is synthesized using Quartus II and programmed onto an FPGA board for real-world testing.

### Performance Evaluation

- **Without Forwarding**: Execution time = 5598 ns
- **With Forwarding**: Execution time = 3861 ns
- **Performance Improvement**: 31.1%

#### Hardware Cost
The hardware cost is evaluated based on the number of logic elements used in the FPGA:

- **Without Forwarding**: 7753 logic elements
- **With Forwarding**: 9564 logic elements
- **Hardware Cost Increase**: 23%

#### Cache Implementation
The cache implementation further improves performance by reducing memory access latency. The cache is designed as a two-way set-associative cache with an LRU (Least Recently Used) replacement policy.

- **Cache Performance Improvement**: 26% increase in performance compared to using external SRAM.

### How to Run the Project
1. **Simulation**: Use ModelSim to simulate the Verilog code. The testbench provided can be used to verify the functionality of the processor.
2. **Synthesis**: Use Quartus II to synthesize the design for an FPGA. The target device used in this project is the Cyclone II EP2C35F672C6.
3. **FPGA Testing**: Program the synthesized design onto the FPGA board and test the processor with different instructions.

## Repository Contents
- [**Verilog Code**](./src/): Contains the Verilog code for the processor, including all pipeline stages, hazard unit, forwarding unit, SRAM integration, and cache.
- **[Testbench](./src/testbench.v)**: Includes the testbench used for simulation and testing.
- **[Documentation](./report/ComputerArchitectureLabReport-810100165-810100129.pdf)**: Includes the project report and additional documentation.
