// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {Script} from "forge-std/Script.sol";
import {IdentityToken} from "../src/IdentityToken.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract Deploy is Script {
    function run() external returns (IdentityToken) {
        HelperConfig config = new HelperConfig();
        (uint256 key) = config.activeNetworkConfig();

        vm.startBroadcast(key);
        IdentityToken token = new IdentityToken();
        vm.stopBroadcast();
        return token;
    }
}