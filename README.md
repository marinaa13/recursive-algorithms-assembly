# Networked Suricata

Implementation of recursive and algorithmic routines in **x86 Assembly**, focused on network rule validation and traversal algorithms.

## Overview
This project contains several independent low-level modules demonstrating recursion, stack management, and data processing in assembly.  
The implementation includes expression validation, sorting and searching algorithms, depth-first traversal, and 64-bit functional programming extensions.

**Language:** Assembly (x86 / x64, NASM syntax)  
**Focus:** Recursion, algorithm design, 64-bit extensions, function calls, and stack operations  

---

## Features

### Parenthesinator
Checks the correctness of nested parentheses using a stack-based approach.  
Returns `0` for valid parenthesis sequences and `1` otherwise.

### Divide et Impera
Implements two recursive algorithms:
- **`quick_sort()`** — sorts an array of integers in ascending order.  
- **`binary_search()`** — recursively finds the index of a target element or returns `-1` if not found.

### Depth First Search
Traverses a directed graph using recursion and prints each visited node.  
The algorithm uses a function pointer (`expand`) to obtain node neighbors dynamically.

### 64-bit Bonus: Map & Reduce
Implements functional abstractions in 64-bit assembly:
- **`map()`** — applies a function to each element of an array and stores results in another.  
- **`reduce()`** — accumulates values from an array using a binary operation.

---

## Learning Outcomes
- Implemented recursion and algorithmic control flow in assembly  
- Managed function calls and stack frames efficiently  
- Practiced low-level data structure traversal and memory handling  
- Extended concepts to 64-bit mode and functional paradigms  
