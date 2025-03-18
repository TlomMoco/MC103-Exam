const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying TokenSwap with deployer:", deployer.address);

    const tokenA = "0x3df14CfE1d42ebeeE766eaF1D185c5a947C0752f"; // Replace with actual address
    const tokenB = "0x7d122506a96Fe9A338E0D6f6f1e3C8c08Dd563ae"; // Replace with actual address
    const swapRate = hre.ethers.parseUnits("2", 18); // 1 TokenA = 2 TokenB
    const owner = deployer.address; // Owner of the contract

    const TokenSwap = await hre.ethers.deployContract("TokenSwap", [
        tokenA, tokenB, swapRate, owner
    ]);

    await TokenSwap.waitForDeployment();
    console.log("TokenSwap deployed at:", await TokenSwap.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});