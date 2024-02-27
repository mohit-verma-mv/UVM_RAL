/*

Four variables to keep track of hardware register in a verification environment.

1. Desired Value 
	Value to be set in the next transaction
2. Mirrored Value
	current known value of register
3. Reest
	save the register's reset value
4. Value
	the value sampled during coverage or the value when the field is randomized 

*/