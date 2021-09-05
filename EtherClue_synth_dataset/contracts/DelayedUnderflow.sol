pragma solidity >=0.5.8;
contract DelayedUnderflow {
    uint underflow = 0;
	function trigger(uint many) public returns(uint) { 
		uint somevalue = 0;
		// Generate extra instructions in tx.
		for(uint i = 0; i < many; i++){
		    somevalue = somevalue + 1;
		}
		// Trigger underflow.
		underflow = 0;
		underflow = underflow - 1;
		return underflow;
	}
}