//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./Item.sol";
import "./Owner.sol";

contract ItemManager is Owner{
    
    enum SupplyChainSteps {Created , Paid , Delivered}
    
    struct S_Items {
        Item _item;
        SupplyChainSteps _step;
        string _identifier;
    }
    
    uint index;
    
    mapping(uint => S_Items) public items;
    
    event SupplyChainStep(uint _itemIndex, uint _step, address _address);
    
    function CreateItem(string memory _identifier, uint _priceInWei) public onlyOwner {
        Item item = new Item(this, _priceInWei, index);
        items[index]._item = item;
        items[index]._step = SupplyChainSteps.Created;
        items[index]._identifier = _identifier;
        emit SupplyChainStep(index, uint(items[index]._step), address(item));
        index++;
    }
    
    function triggerPayment(uint _index) public payable  {
        Item item = items[_index]._item;
        require(address(item) == msg.sender, "Only items are allowed to update themselves.");
        require(item.priceInWei() == msg.value,"Not fully Paid");
        require(items[_index]._step == SupplyChainSteps.Created,"its further to chain");
        items[_index]._step = SupplyChainSteps.Paid;
        emit SupplyChainStep(_index, uint(items[_index]._step), address(item));
        
    }
    
    function triggerDelivery(uint _index) public onlyOwner {
        require(items[_index]._step == SupplyChainSteps.Paid,"its further to chain or Not Paid.");
        items[_index]._step = SupplyChainSteps.Delivered;
        emit SupplyChainStep(_index, uint(items[_index]._step), address(items[_index]._item));
    }
}