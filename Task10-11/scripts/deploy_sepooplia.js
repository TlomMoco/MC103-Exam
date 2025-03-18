const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying SePoopliaCoin with deployer:", deployer.address);

    const initialSupply = hre.ethers.parseUnits("1000000", 18); // 1M SPOOP
    const maxSupply = hre.ethers.parseUnits("10000000", 18); // 10M SPOOP

    const SePoopliaCoin = await hre.ethers.deployContract("SePoopliaCoin", [
        deployer.address, // Owner
        initialSupply,
        maxSupply
    ]);

    await SePoopliaCoin.waitForDeployment();
    console.log("SePoopliaCoin deployed at:", await SePoopliaCoin.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
