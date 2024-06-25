// SPDX-License-Identifier: MIT

// Have our invariant aka properties that should always hold

// 1. The total supply of DSC should be less than the total value of collateral

// 2. Getter view functions should never revert <- evergreen invariant

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {StdInvariant} from "forge-std/StdInvariant.sol";
import {DeployDSC} from "../../script/DeployDSC.s.sol";
import {DSCEngine} from "../../src/DSCEngine.sol";
import {DecentralizedStableCoin} from "../../src/DecentralizedStableCoin.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20Mock} from "../mocks/ERC20Mock.sol";

contract OpenInvariantsTest is StdInvariant, Test {
    DeployDSC deployer;
    DSCEngine dsce;
    DecentralizedStableCoin dsc;
    HelperConfig config;
    address weth;
    address wbtc;

    function setUp() external {
        deployer = new DeployDSC();
        (dsc, dsce, config) = deployer.run();
        (,, weth, wbtc,) = config.activeNetworkConfig();
        targetContract(address(dsce));
    }

    /// forge-config: default.invariant.fail-on-revert = false
    function invariant_protocolMustHaveMoreValueThatTotalSupplyDollars() public view {
        uint256 totalSupply = dsc.totalSupply();
        uint256 wethDeposted = ERC20Mock(weth).balanceOf(address(dsce));
        uint256 wbtcDeposited = ERC20Mock(wbtc).balanceOf(address(dsce));

        uint256 wethValue = dsce.getUsdValue(weth, wethDeposted);
        uint256 wbtcValue = dsce.getUsdValue(wbtc, wbtcDeposited);

        console.log("wethValue: %s", wethValue);
        console.log("wbtcValue: %s", wbtcValue);

        assert(wethValue + wbtcValue >= totalSupply);
    }
}
