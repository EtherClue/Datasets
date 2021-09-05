pragma solidity >=0.5.8;
contract Subscription {
	mapping (address => uint) subscriptions;
	event newsubscription(address a);
	function subscribe() public payable {
		subscriptions[msg.sender] = 1;
		emit newsubscription(msg.sender);
	}
	function isSubscribed(address a) public view returns(bool){
		return subscriptions[a] == 1;
	}
}