pragma solidity >=0.5.8;
contract TargetUnderflow {
	uint at = 0;
	mapping(uint=>uint) space;
	function trigger(uint where) public returns(uint) { 
		space[at] = 0;
		space[where] = space[where] - 1;
		at = where;
	}
}