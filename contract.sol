// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Transaction {
    struct Product {
        string name;
        uint price;
        address owner;
        bool isSold;
    }
    mapping(uint => Product) public products;
    uint public productCount;

    function createProduct(string memory _name, uint _price) public {
        require(_price > 0, "Product price must be greater than zero");
        productCount++;
        products[productCount] = Product(_name, _price, msg.sender, false);
    }

    function purchaseProduct(uint _productId) public payable {
        Product storage _product = products[_productId];
        require(!_product.isSold, "Product already sold");
        require(msg.value >= _product.price, "Not enough Ether");

        _product.owner = msg.sender;
        _product.isSold = true;
    }
}