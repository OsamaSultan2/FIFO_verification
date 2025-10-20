# FIFO_verification
# SystemVerilog FIFO Verification Project

![Language](https://img.shields.io/badge/Language-SystemVerilog-blue.svg)

## 📖 Overview

This repository contains a complete verification environment for a **First-In, First-Out (FIFO)** memory design. The testbench is built from scratch using **SystemVerilog** and employs a class-based, object-oriented approach to ensure robustness and reusability.

---

## 📝 FIFO Design Features

The Design Under Test (DUT) is a synchronous FIFO with the following characteristics:

* **Data Width**: `16-bit`
* **Depth**: `8-locations`
* **Status Flags**:
    * `full`: Asserts when the FIFO is full.
    * `empty`: Asserts when the FIFO is empty.
    * `almost_full`:   Asserts when the FIFO is nearing capacity.
    * `almost_empty`:  Asserts when the FIFO has few entries remaining.
* **Reset**: Asynchronous/Synchronous active-high/low reset.

-
```
