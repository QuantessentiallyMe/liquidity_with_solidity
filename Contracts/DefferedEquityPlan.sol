pragma solidity ^0.5.0;

// equity plan
contract DeferredEquityPlan {
    address human_resources;
    
    function fastforward() public {
        now += 100 days;
    }


    address payable employee; // Bob
    bool active = true; // this employee is active at the start of the contract
    uint total_shares = 1000;
    uint annual_distribution = 250;
    uint start_time = now;
    uint unlock_time = now + 365;// permanently store the time this contract was initialized
    uint public distributed_shares; // starts at 0

    constructor(address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }

    function distribute() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to execute this contract.");
        require(active == true, "Contract not active.");
        require(unlock_time <= now,"This is not the appropriate time!");
        require(distributed_shares < total_shares, "You have too many shares!");
        unlock_time = unlock_time + 365;
        distributed_shares = (now - start_time) /365 * annual_distribution;
        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }

    // human_resources and the employee can deactivate this contract at-will
    function deactivate() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to deactivate this contract.");
        active = false;
    }
    function() external payable {
        revert("Do not send Ether to this contract!");
    }
}

