const ItemManager = artifacts.require("./ItemManager.sol")

contract("ItemManger", accounts => {
    it(" should let you create new Items.", async () => {
        const ItemManagerInstance = await ItemManager.deployed()
        const itemName = "test1"
        const itemPrice = "500"

        const result = await ItemManagerInstance.CreateItem(itemName,itemPrice, {from: accounts[0]})
        assert.equal(result.logs[0].args._itemIndex,0,"There should be one item index there.")
        const item = await ItemManagerInstance.items(0);
        assert.equal(item._identifier, itemName, " the item had different identifier.")
    })
    
})