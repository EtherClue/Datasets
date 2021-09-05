pragma solidity >=0.5.8;
import "./Subscription.sol";
contract ProductVote {
	Subscription public s 
		= Subscription(0x40BeDB284ac2a18688eEee7094cF7afc85eBE831); 
	mapping(address=>uint) 	voters;		// accounts that have voted.
	mapping(uint=>uint) 	votes;		// votes for each product.
	event votecast(address voter, uint to);
	// Allow people to vote for preferred product. Only allowed once.
	function vote(uint productCode) public {
		if(!s.isSubscribed(msg.sender)) { revert ("No Subscription"); }
		// Revert if voter has already voted.
		if(voters[msg.sender] == 1){ revert("Already Voted!"); }
		// Send thank you to voter of 100,000 wei.
		(bool b,) = msg.sender.call.value(100000)("");
		// -- METHOD 01 --
		if (!b) { revert("Error sending reward!"); }
		// Stop voter from voting again.
		voters[msg.sender] = 1;
		emit votecast(msg.sender, productCode);
		// Register vote for product.
		votes[productCode]++;
		// -- METHOD 02 --
		/*if(b){
			// Stop voter from voting again.
			voters[msg.sender] = 1;
			emit votecast(msg.sender, productCode);
			// Register vote for product.
			votes[productCode]++;			
		}*/
		// When using METHOD 02 instead of METHOD 01 could
		// not trigger reentrancy. To check on this later.
	}
	/* Start admin functions */
	address owner;						// administrator.
	// Default constructor.
	constructor() public payable { owner = msg.sender; }
	// Send funds for market research.
	function addfunds() public payable {}
	// Retrieve any funds left for this market research.
	function getfunds() public {
		if(msg.sender != owner) revert();
	    (bool b,) = msg.sender.call.value(address(this).balance)("");
		if(!b) { revert(); }
	}
	// Check how many funds left for this market research.
	function availablefunds() public view returns(uint) {
	    return address(this).balance;
	}
}