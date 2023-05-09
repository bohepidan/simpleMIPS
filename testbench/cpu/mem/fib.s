  addi $1, $0, 1
  addi $2, $0, 1
  add  $4, $0, $0
  addi $5, $0, 6
_loop:
  add  $3, $1, $2
  addi $2, $1, 0
  addi $1, $3, 0
  addi $4, $4, 1
  bne  $4, $5, _loop
_stall:
  j _stall


