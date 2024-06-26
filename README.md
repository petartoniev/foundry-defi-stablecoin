Foundry DeFi Stablecoin
This is a section of the Cyfrin Foundry Solidity Course.

DSCEngine Example Decentralized Stablecoin

About
This project is meant to be a stablecoin where users can deposit WETH and WBTC in exchange for a token that will be pegged to the USD.
It has the necessary mintDsc, burnDsc, liquidate, depositCollateral, redeemCollateral functions and more.

Foundry DeFi Stablecoin

In this repo we cover Unit and Fuzzing Tests.

forge test
Test Coverage
forge coverage
and for coverage based testing:

forge coverage --report debug
Deployment to a testnet or mainnet
Setup environment variables
You'll want to set your SEPOLIA_RPC_URL and PRIVATE_KEY as environment variables. You can add them to a .env file, similar to what you see in .env.example.

PRIVATE_KEY: The private key of your account (like from metamask). NOTE: FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.
You can learn how to export it here.
SEPOLIA_RPC_URL: This is url of the sepolia testnet node you're working with. You can get setup with one for free from Alchemy
Optionally, add your ETHERSCAN_API_KEY if you want to verify your contract on Etherscan.

Get testnet ETH
Head over to faucets.chain.link and get some testnet ETH. You should see the ETH show up in your metamask.

Deploy
make deploy ARGS="--network sepolia"
Scripts
Instead of scripts, we can directly use the cast command to interact with the contract.

For example, on Sepolia:

Get some WETH
cast send 0xdd13E55209Fd76AfE204dBda4007C227904f0a81 "deposit()" --value 0.1ether --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY
Approve the WETH
cast send 0xdd13E55209Fd76AfE204dBda4007C227904f0a81 "approve(address,uint256)" 0x091EA0838eBD5b7ddA2F2A641B068d6D59639b98 1000000000000000000 --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY
Deposit and Mint DSC
cast send 0x091EA0838eBD5b7ddA2F2A641B068d6D59639b98 "depositCollateralAndMintDsc(address,uint256,uint256)" 0xdd13E55209Fd76AfE204dBda4007C227904f0a81 100000000000000000 10000000000000000 --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY
Estimate gas
You can estimate how much gas things cost by running:

forge snapshot
And you'll see an output file called .gas-snapshot