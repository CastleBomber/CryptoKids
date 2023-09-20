// SPDX-License-Identifier: MIT

/**
 * Author: CastleBomber
 * Project: CryptoKids
 * Description: Sends crypto as a parent to your children
 *
 * Acknowledgements: Travis Media's Youtube Solidity Tutorial For Developers Tutorial
 */

pragma solidity ^0.8.18;

contract CryptoKids{
    // Owner Dad
    address owner;

    event LogKidFundingRecieved(address addr, uint amount, uint contractBalance);

    constructor() {
        owner = msg.sender;
    }

    struct Kid {
        address payable walletAddress;
        string firstName;
        string lastName;
        uint releaseTime;
        uint amount;
        bool canWithdraw;
    }

    Kid[] public kids;

    modifier onlyOwner() {
        require(msg.sender ==  owner, "Only the owner can add kids");
        _;
    }

    function addKid(address payable walletAddress, string memory firstName, string memory lastName,
        uint releaseTime, uint amount, bool canWithdraw) public onlyOwner {
            kids.push(Kid(
                walletAddress, firstName, lastName, releaseTime, amount, canWithdraw
            ));
    }

    function balanceOf() public view returns(uint){
        return address(this).balance;
    }

    // Deposit funds to contract, specifically a kid's account
    function deposit(address walletAddress) payable public {
        addToKidsBalance(walletAddress);
    }

    function addToKidsBalance(address walletAddress) private{
        for(uint i = 0; i < kids.length; i++){
            if(kids[i].walletAddress == walletAddress){
                kids[i].amount += msg.value;
                emit LogKidFundingRecieved(walletAddress, msg.value, balanceOf());
            }
        }
    }

    function getIndex(address walletAddress) view private returns(uint){
        for(uint i = 0; i < kids.length; i++){
            if(kids[i].walletAddress == walletAddress){
                return i;
            }
        }

        return 999; // Random default value due to int vs uint
    }

    // Kid checks if able to withdraw
    function availableToWithdraw(address walletAddress) public returns(bool){
        uint i = getIndex(walletAddress);

        require(block.timestamp > kids[i].releaseTime, "You cannot withdraw yet");

        if(block.timestamp > kids[i].releaseTime){
            kids[i].canWithdraw = true;
            return true;
        } else {
            return false;
        }
    }

    // Withdraw money
    function withdraw(address payable walletAddress) payable public{
        uint i = getIndex(walletAddress);
        require(msg.sender == kids[i].walletAddress, "You must be the kid to withdraw");
        require(kids[i].canWithdraw == true, "You are not able to withdraw at this time");
        kids[i].walletAddress.transfer(kids[i].amount);
    } 
}