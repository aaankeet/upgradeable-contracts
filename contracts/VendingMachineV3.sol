// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract VendingMachineV3 is Initializable {
  // these state variables and their values
  // will be preserved forever, regardless of upgrading
  uint public numSodas;
  address public owner;
  
  function initialize(uint _numSodas, uint _numSnack) public initializer {
    numSodas = _numSodas;
    owner = msg.sender;
    numSnack = _numSnack;
  }
  
  mapping(address => uint256) public numOfSodaPurchased;
  mapping(address => uint256) public numOfSnackPurchased;
  uint public numSnack;

  function purchaseSoda() public payable {
    require(msg.value == 1000 wei, "You must pay 1000 wei for a soda!");
    --numSodas;
    numOfSodaPurchased[msg.sender]++;
  }

  function addSoda(uint amount) public onlyOwner {
    require(amount < 5, "Only 5 Sodas can be added at a time");
    numSodas +=amount;
  }

  function purchaseSnack() public payable {
    require(msg.value == 1000 wei, "You must pay 1000 wei for a snack");
    --numSnack;
    numOfSnackPurchased[msg.sender]++;
  }

  function addSnack(uint amount) public onlyOwner {
    require(amount < 5, "Only 5 Snacks can be added at a time");
    numSnack +=amount;
  }
  function removeSoda(uint amount) public onlyOwner {
    numSodas -=amount;
  }
  function removeSnack(uint amount) public onlyOwner {
    numSnack -= amount;
  }

  function withdrawProfits() public onlyOwner {
    require(address(this).balance > 0, "Profits must be greater than 0 in order to withdraw!");
    (bool sent, ) = owner.call{value: address(this).balance}("");
    require(sent, "Failed to send ether");
  }

  function setNewOwner(address _newOwner) public onlyOwner {
    owner = _newOwner;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Only owner can call this function.");
    _;
  }
}