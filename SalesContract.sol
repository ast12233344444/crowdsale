pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SalesContract{
    address owner;
    IERC20 token;
    uint price = 1;
    uint deploymentTime;
    uint availableTime;

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }    
    
    constructor(address tokenContract, uint toldprice, uint available){
        owner = msg.sender;
        token = IERC20(tokenContract);
        price = toldprice;
        deploymentTime = block.timestamp;
        availableTime = available;
    }

    function buy(uint amount)external payable{
        require(amount * price <= msg.value);
        require(block.timestamp >= deploymentTime + availableTime);

        token.transfer(msg.sender, amount);
    }

    function getprofit() external onlyOwner{
        payable(owner).transfer(address(this).balance);
    }


}