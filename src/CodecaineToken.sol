// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract CodecaineToken is ERC20 {
    constructor(uint256 _initialSupply) ERC20("Codecaine", "CODC") {
        _mint(msg.sender, _initialSupply);
    }
}
