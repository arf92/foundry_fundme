// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "../lib/forge-std/src/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./helper.config.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        // before startbroadcast -> Not a 'real' tx
        HelperConfig helperConfig = new HelperConfig();
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        // after startBroadcast -> real tx
        // Using the address that calls the test contract, has all subsequent calls (at this call depth only) create transactions that can later be signed and sent onchain
        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        // Stops collecting onchain transactions
        vm.stopBroadcast();
        return fundMe;
    }
}
