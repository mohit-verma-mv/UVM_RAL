/*

We can access register in UVM by two ways:

1.Frontdoor Access

->In this we apply actual transaction to DUT signals to either read the content 
of a register or write data to a register.
->If we want to write the data to a register, then we need to apply the respective signal to an input port of a DUT.
->In frontdoor access we use read and write method.

2.Backdoor Access

->In this we do not need to apply transaction to the ports of a DUT 
to access or write data to register.
->We simply need to specify the path of the register and then we will 
be directly updating the register.
->That way we directly access the internal register of a DUT and perform 
read and write.
->In backdoor access we use peek and poke method.

*/