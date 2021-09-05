pragma solidity >=0.5.8;
contract Bank {
	// Store each account balance.
	mapping (address => uint) public accounts;
	// events.
	event deposit(address account, uint amount);
	event withdrawal(address account, uint amount);
	/// Allow third party accounts to deposit ether with the bank.
	function deposit() public payable {
		accounts[msg.sender] += msg.value;
		emit deposit(msg.sender, msg.value);
	}
	// Allow third party accounts to withdraw ether from the bank.
	function withdraw(uint amount) public {
		if(amount <= accounts[msg.sender]){
			(bool b,) = msg.sender.call.value(amount)("");
			if (!b) { revert(); }
			balances[msg.sender] -= amount;
			emit withdrawal(msg.sender, amount);
		}
		else{ revert(); }
	}
}