# Multi Cycle RISC-V Processor
Design and implementation of RISC-V processor with a multi-cycle datapath and controller.
## Commands

```ruby
R_Type:  add, sub, and, or, slt
```
```ruby
I_Type:  lw, addi, xori, ori, slti, jalr
```
```ruby
S_Type:  sw
```
```ruby
J_Type:  jal
```
```ruby
B_Type:  beq, bne, blt, bge
```
```ruby
U_Type:  lui
```
## Datapath
<img src="/readme_images/Datapath.png">

## Controller
<img src="/readme_images/CONTROLLER.png">

### Immediate Extension Unit Controller
<img src="/readme_images/Imm_Ext.jpg">

### ALU Opcode Controller
<img src="/readme_images/ALU_OP.jpg">

### ALU Controller
<img src="/readme_images/ALU_CONT.jpg">

## Test Code
The following assembly code can be converted to machine code using [RISC-V Online Assembler](https://riscvasm.lucasteske.dev/#).

```ruby
addi x8,x0,30
sub x9,x8,x7
and x10,x8,x7
or x11,x8,x7
slt x12,x8,x7
slt x12,x8,x7
xori x13,x7,13
ori x14,x7,13
slti x15,x7,13
sw x8,400(x7)
jalr x16,x7,10
lui x17,50
```
