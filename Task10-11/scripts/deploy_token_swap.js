const hre = require("hardhat");
const { ethers } = hre; // Ensure ethers is properly imported

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying TokenSwap with deployer:", deployer.address);

    // Token Addresses (Ensure they are correct)
    const tokenA = "0x3df14CfE1d42ebeeE766eaF1D185c5a947C0752f"; // FundsNotFound Token
    const tokenB = "0x7d122506a96Fe9A338E0D6f6f1e3C8c08Dd563ae"; // SePoopliaCoin Token
    
    // Swap rate (1 TokenA = 2 TokenB) → needs 1e18 scaling
    const swapRate = ethers.parseUnits("2", 18); 
    
    // Deployer will be the initial owner
    const initialOwner = deployer.address;

    // Deploy contract
    const TokenSwap = await hre.ethers.getContractFactory("TokenSwap");
    const tokenSwap = await TokenSwap.deploy(tokenA, tokenB, swapRate, initialOwner);

    // Wait for deployment confirmation
    await tokenSwap.waitForDeployment();
    
    console.log("TokenSwap deployed at:", await tokenSwap.getAddress());
}

// Execute deployment
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
