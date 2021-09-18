//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./ItemManager.sol";

contract Item{
    uint public priceInWei;
    uint public index;
    uint public paidWei;
    
    ItemManager public parentcontract;
    
    constructor(ItemManager _parentcontract, uint _priceInWei , uint _index){
        priceInWei = _priceInWei;
        index = _index;
        parentcontract = _parentcontract;
    }
    
    receive() external payable{
        require(priceInWei == msg.value,"WE dont accept patrial payments.");
        require(paidWei == 0 , "You have already paid for the product");
        paidWei += msg.value;
        (bool success,) = address(parentcontract).call{value:msg.value}(abi.encodeWithSignature("triggerPayment(uint256)",index));
        require(success,"Delivery did not work.");
    }
    
    fallback() external {
        
    }
}