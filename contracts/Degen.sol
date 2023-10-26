// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";


contract HiDegen is ERC20, Ownable {

    constructor() ERC20("Degen", "DGN") {
        _mint(msg.sender,250);
    }

        function mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
        }

        function burn(uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "You require more tokens");
            _burn(msg.sender,_value);
        }

        function bal() external view returns (uint256) {
            return this.balanceOf(msg.sender);
        }
        
        function transferTokens(address _receiver, uint256 _value) external {
            if(balanceOf(msg.sender) < _value){
                revert();
            }
            approve(msg.sender, _value);
            transferFrom(msg.sender,_receiver, _value);
        }

        function viewItems() external pure returns (string memory) {
            return "You can buy the following Items! 1 Majora's Mask : 150DGN 2 Dragon Bones 50DGN 3 Magic Sled 10DGN 4 Navatar 2 DGN";
        }

        function buy(uint8 _itemNumber) external payable returns (bool) {
            if (_itemNumber == 1) {
                require(this.balanceOf(msg.sender) >= 150, "Insufficient Tokens!");
                approve(msg.sender, 150);
                transferFrom(msg.sender, owner(), 150);
                console.log ("Congratulations! You have successfully purchased Majora's Mask!");       
                return(true);     
            }
            else if (_itemNumber == 2) {
                require(this.balanceOf(msg.sender) >= 50, "Insufficient Tokens!");
                approve(msg.sender, 50);
                transferFrom(msg.sender, owner(), 50);
                console.log ("Congratulations! You have successfully purchased some Dragon Bones!");     
                return(true);         
            }
            else if (_itemNumber == 3) {
                require(this.balanceOf(msg.sender) >= 10, "Insufficient Tokens!");
                approve(msg.sender, 10);
                transferFrom(msg.sender, owner(), 10);
                console.log ("Congratulations. You have successfully purchased a Magic Sled!");
                return(true);              
            }
            else if (_itemNumber == 4) {
                require(this.balanceOf(msg.sender) >= 2, "Insufficient Tokens!");
                approve(msg.sender, 2);
                transferFrom(msg.sender, owner(), 2);
                console.log ("Congratulations. You have successfully purchased a Navatar!"); 
                return(true);             
            }
            else {
                console.log("Please choose a valid item!");            
                return(false);  
            }
        }
}