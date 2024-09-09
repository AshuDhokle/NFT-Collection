import { ethers, parseEther } from "ethers";
import fs from 'fs-extra';
import 'dotenv/config';

async function main() {
    // Set up gas overrides (if needed)
    const overrides = {
        gasPrice: 20000000000, // Example value, adjust as needed
        gasLimit: 6721975, // Adjust according to your contract's needs
    };

    const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

    const abi = JSON.parse(fs.readFileSync("../whiteListContract_whiteListContract_sol_WhiteList.abi", 'utf8'));
    const bin = fs.readFileSync("../whiteListContract_whiteListContract_sol_WhiteList.bin", 'utf8').toString();
    
    const whiteListContractFactory = new ethers.ContractFactory(abi, bin, wallet);

    console.log("Deploying contract...");

    const contract = await whiteListContractFactory.deploy(overrides);
    console.log(`Contract deployed at address: ${await contract.getAddress()}`);
}

// Handle promise rejections and exit process
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error("Error during deployment:", error);
        process.exit(1);
    });
