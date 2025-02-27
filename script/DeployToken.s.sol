// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {CodecaineToken} from "src/CodecaineToken.sol";

contract DeployToken is Script {
    uint256 public constant INITIAL_TOKEN_SUPPLY = 1_000_000 ether; // 1M tokens with 18 decimals

    function run() external {
        vm.startBroadcast(msg.sender);
        new CodecaineToken(INITIAL_TOKEN_SUPPLY);
        vm.stopBroadcast();
    }
}
