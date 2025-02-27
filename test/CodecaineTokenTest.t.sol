// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {DeployToken} from "../script/DeployToken.s.sol";
import {CodecaineToken} from "../src/CodecaineToken.sol";
import {Test, console} from "forge-std/Test.sol";

interface MintableToken {
    function mint(address, uint256) external;
}

contract CodecaineTokenTest is Test {
    uint256 public constant INITIAL_SUPPLY = 1_000_000 ether; // 1 million tokens with 18 decimal places
    uint256 BOB_STARTING_AMOUNT = 100 ether;

    CodecaineToken public codecaineToken;
    DeployToken public deployer;
    address public deployerAddress;
    address bob;
    address alice;

    function setUp() public {
        deployer = new DeployToken();

        codecaineToken = new CodecaineToken(INITIAL_SUPPLY);
        codecaineToken.transfer(msg.sender, INITIAL_SUPPLY);

        bob = makeAddr("bob");
        alice = makeAddr("alice");

        vm.prank(msg.sender);
        codecaineToken.transfer(bob, BOB_STARTING_AMOUNT);
    }

    function testInitialSupply() public view {
        assertEq(codecaineToken.totalSupply(), deployer.INITIAL_TOKEN_SUPPLY());
    }

    function testUsersCantMint() public {
        vm.expectRevert();
        MintableToken(address(codecaineToken)).mint(address(this), 1);
    }

    function testAllowances() public {
        uint256 initialAllowance = 1000;

        // Bob approves Alice to spend tokens on his behalf
        // Initial Allowance must be > transfer ammount

        vm.prank(bob);
        codecaineToken.approve(alice, initialAllowance);
        uint256 transferAmount = 500;

        vm.prank(alice);
        codecaineToken.transferFrom(bob, alice, transferAmount);
        assertEq(codecaineToken.balanceOf(alice), transferAmount);
        assertEq(
            codecaineToken.balanceOf(bob),
            BOB_STARTING_AMOUNT - transferAmount
        );
    }
}
