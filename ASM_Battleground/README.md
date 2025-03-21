# ASM_Battleground

This repository contains MASM assembly programs developed to explore x86 assembly language concepts like stack operations, array manipulation, and sorting algorithms. Each program uses the Irvine32 library.

## Programs

### 1. Bubble Sort Implementation
- **Description**: Sorts an array of 10 signed 32-bit integers in ascending order using the Bubble Sort algorithm. Features nested loops and conditional jumps for comparisons and swaps.

### 2. Array Copy and Print
- **Description**: Copies elements from `arr1` to `arr2` using indexed indirect addressing and prints both arrays. Highlights array traversal and memory addressing techniques.

### 3. Matrix Initialization and Printing
- **Description**: Initializes a 4x4 matrix with values 1 to 16 and prints it as a grid. Shows how to manage 2D arrays and use nested loops in assembly.

### 4. Even Numbers Stack Operation
- **Description**: Pushes even numbers from `arr1` onto the stack, pops them into `arr3` in reverse order, and prints the result. Demonstrates stack manipulation and bitwise even/odd checks.

## Usage
- Assemble and run each `.asm` file with MASM and the Irvine32 library.
- .\run filename ; Inside of a cli or Powershell. 