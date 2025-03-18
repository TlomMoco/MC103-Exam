const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying FundsNotFound with deployer:", deployer.address);

    const initialSupply = hre.ethers.parseUnits("500000", 18); // 500K FNF
    const maxSupply = hre.ethers.parseUnits("5000000", 18); // 5M FNF

    const FundsNotFound = await hre.ethers.deployContract("FundsNotFound", [
        deployer.address, // Owner
        initialSupply,
        maxSupply
    ]);

    await FundsNotFound.waitForDeployment();
    console.log("404FundsNotFound deployed at:", await FundsNotFound.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
