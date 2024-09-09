import { ethers } from "ethers";
import fs from 'fs-extra'
import "dotenv/config"

async function main() {
    const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY,provider);

    const abi = JSON.parse(fs.readFileSync("../whiteListContract_cryptoDevs_sol_CryptoDevs.abi", 'utf8'));
    const bin = fs.readFileSync("../whiteListContract_cryptoDevs_sol_CryptoDevs.bin", 'utf8').toString();
    
    const CryptoDevsFactory = new ethers.ContractFactory(abi,bin,wallet);

    console.log('deploying ...');
    
    const contract = await CryptoDevsFactory.deploy("0xF6b33f8301A01e7d1A2E0Aaf8591Ef5b19c9277d");

    console.log("Address : ", await contract.getAddress());
    

}

main().then(()=> process.exit(0))
   .catch((error)=>{
    console.log(error);
    process.exit(1);
   })