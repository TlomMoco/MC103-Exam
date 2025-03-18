// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenSwap is Ownable {
    IERC20 public tokenA;
    IERC20 public tokenB;
    uint256 public swapRate; // 1 TokenA = swapRate TokenB

    event Swap(address indexed user, address indexed fromToken, address indexed toToken, uint256 amountIn, uint256 amountOut);

    constructor(address _tokenA, address _tokenB, uint256 _swapRate, address initialOwner) Ownable(initialOwner) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        swapRate = _swapRate;
    }

    function swapAtoB(uint256 amountA) external {
        require(amountA > 0, "Amount must be greater than zero");
        require(tokenA.balanceOf(msg.sender) >= amountA, "Insufficient TokenA balance");
        require(tokenA.allowance(msg.sender, address(this)) >= amountA, "TokenA allowance too low");

        uint256 amountB;
        unchecked {
            amountB = (amountA * swapRate) / 1e18;
        }

        require(tokenB.balanceOf(address(this)) >= amountB, "Insufficient TokenB liquidity");

        tokenA.transferFrom(msg.sender, address(this), amountA);
        tokenB.transfer(msg.sender, amountB);

        emit Swap(msg.sender, address(tokenA), address(tokenB), amountA, amountB);
    }

    function swapBtoA(uint256 amountB) external {
        require(amountB > 0, "Amount must be greater than zero");
        require(tokenB.balanceOf(msg.sender) >= amountB, "Insufficient TokenB balance");
        require(tokenB.allowance(msg.sender, address(this)) >= amountB, "TokenB allowance too low");

        uint256 amountA;
        unchecked {
            amountA = (amountB * 1e18) / swapRate;
        }

        require(tokenA.balanceOf(address(this)) >= amountA, "Insufficient TokenA liquidity");

        tokenB.transferFrom(msg.sender, address(this), amountB);
        tokenA.transfer(msg.sender, amountA);

        emit Swap(msg.sender, address(tokenB), address(tokenA), amountB, amountA);
    }

    function setSwapRate(uint256 newRate) external onlyOwner {
        require(newRate > 0, "Swap rate must be greater than zero");
        swapRate = newRate;
    }

    function depositTokenA(uint256 amount) external onlyOwner {
        tokenA.transferFrom(msg.sender, address(this), amount);
    }

    function depositTokenB(uint256 amount) external onlyOwner {
        tokenB.transferFrom(msg.sender, address(this), amount);
    }

    function withdrawTokenA(uint256 amount) external onlyOwner {
        tokenA.transfer(msg.sender, amount);
    }

    function withdrawTokenB(uint256 amount) external onlyOwner {
        tokenB.transfer(msg.sender, amount);
    }
}