//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;



contract Owner {
    
    address owner;
    
    constructor() {
        owner = msg.sender;
        
    }
    
    modifier onlyOwner {
        require(msg.sender == owner,"You are not the owner.");
        _;
    }
    
    function isowner() public view returns(address){
        return owner;
    }
    
    // creating IsOwner with return bool for allownce contract require.
    
    function IsOwner() internal view returns(bool){
        return isowner() == msg.sender;
    }
    
    event transferDetails(address indexed oldOwner,address indexed newOwner);
    
    /*function deleteOwnership() public onlyOwner {
        setOwner(address(0));
    }*/
    
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0),"The new owner is the zero address.");
        setOwner(newOwner);
    }
    
    function setOwner(address newOwner) private {
        address oldOwner = owner;
        owner = newOwner;
        emit transferDetails(oldOwner,newOwner);
    }
}