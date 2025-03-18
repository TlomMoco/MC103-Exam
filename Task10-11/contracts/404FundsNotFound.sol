// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Capped} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract FundsNotFound is ERC20, ERC20Capped, Ownable, ERC20Permit {
    
    constructor(address initialOwner, uint256 initialSupply, uint256 maxSupply)
        ERC20("404FundsNotFound", "FNF")
        ERC20Capped(maxSupply) // Set max supply using ERC20Capped
        Ownable(initialOwner)
        ERC20Permit("404FundsNotFound")
    {
        require(initialSupply <= maxSupply, "Initial supply exceeds max supply");
        _mint(initialOwner, initialSupply); // Mint initial supply to owner
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= cap(), "Minting exceeds max supply");
        ERC20._mint(to, amount);
    }

    // Explicitly override _update to resolve conflict with ERC20 and ERC20Capped
    function _update(address from, address to, uint256 value) internal override(ERC20, ERC20Capped) {
        super._update(from, to, value);
    }
}