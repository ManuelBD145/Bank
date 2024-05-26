// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;
pragma abicoder v2;

import "forge-std/Test.sol";
import "../src/VulnerableBank.sol";

contract VulnerableBankTest is Test {
    VulnerableBank public bank;
    address public owner;
    address public user1;
    address public user2;
    string private correctPassword = "password123";
    string private incorrectPassword = "wrongpassword";

    function setUp() public {
        bank = new VulnerableBank(5, correctPassword);
        owner = address(this);
        user1 = address(0x1);
        user2 = address(0x2);

        vm.deal(user1, 500 ether); // Asignar 100 ETH a user1
    }

    function testDeposit() public {
        vm.prank(user1);
        bank.deposit{value: 5 ether}();
        assertEq(bank.getBalance(), 5 ether);
    }

    function testWithdraw() public {
        vm.prank(user1);
        bank.deposit{value: 5 ether}();

        vm.prank(user1);
        bank.withdraw(5 ether);
        assertEq(bank.getBalance(), 5 ether);
    }

    function testWithdrawInsufficientBalanceRevert() public {
        vm.prank(user1);
        vm.expectRevert("Insufficient balance");
        bank.withdraw(10 ether);
    }

    function testUpdateInterestRateWithCorrectPassword() public {
        vm.prank(user1);
        bank.updateInterestRate(10, correctPassword);
        assertEq(bank.interestRate(), 10);
    }

    function testUpdateInterestRateWithIncorrectPasswordRevert() public {
        vm.prank(user1);
        vm.expectRevert("Incorrect password");
        bank.updateInterestRate(10, incorrectPassword);
    }

    function testCalculateInterest() public {
        vm.prank(user1);
        bank.deposit{value: 100 ether}();

        uint256 interest = bank.calculateInterest(user1);
        assertEq(interest, 5 ether);
    }

    function testDepositRevertIfZero() public {
        vm.prank(user1);
        vm.expectRevert("Deposit amount must be greater than zero");
        bank.deposit{value: 0 ether}();
    }

    function testWithdrawRevertIfZero() public {
        vm.prank(user1);
        vm.expectRevert("Withdrawal amount must be greater than zero");
        bank.withdraw(0 ether);
    }
}
