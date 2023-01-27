const { ethers, upgrades } = require("hardhat");

// TO DO: Place the address of your proxy here!
const proxyAddress = "0xa765e4037381c2908874ede09Ed314DBDe4E0764";

async function main() {
  const VendingMachineV3 = await ethers.getContractFactory("VendingMachineV3");
  const upgraded = await upgrades.upgradeProxy(proxyAddress, VendingMachineV3);

  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    proxyAddress
  );

  console.log("The current contract owner is: " + upgraded.numSnack());
  console.log("Implementation contract address: " + implementationAddress);
}

main();
