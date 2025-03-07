const hre = require("hardhat");

async function main() {
  const MultiSigFactory = await hre.ethers.getContractFactory("MultiSigFactory")
  const multiSigFactory = await MultiSigFactory.deploy()

  await multiSigFactory.waitForDeployment()

  console.log(
    `MultiSigFactory deployed to ${await multiSigFactory.getAddress()} on ${hre.network.name} network`
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
