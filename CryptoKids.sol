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

    constructor() {
        owner = msg.sender;
    }

    struct Kid {
        address walletAddress;
        string firstName;
        string lastName;
        uint releaseTime;
        uint amount;
        bool canWithdraw;
    }

    Kid[] public kids;

    function addKid(address walletAddress, string memory firstName, string memory lastName,
        uint releaseTime, uint amount, bool canWithdraw) public {
            kids.push(Kid(
                walletAddress, firstName, lastName, releaseTime, amount, canWithdraw
            ));
    }

    function balanceOf() public view returns(uint){
        return address(this).balance;
    }

    // Deposit funds to contract, specifically a kid's account
    function deposit(address walletAddress) payable public {}

    function addToKidsBalance(address walletAddress) private{

    }
    // Kid checks if able to withdraw

    // Withdraw money
}