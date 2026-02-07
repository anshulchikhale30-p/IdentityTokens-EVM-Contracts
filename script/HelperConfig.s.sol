// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    struct NetworkConfig { uint256 deployerKey; }
    NetworkConfig public activeNetworkConfig;

    constructor() {
        if (block.chainid == 31337) activeNetworkConfig = getAnvilConfig();
        else activeNetworkConfig = getSepoliaConfig();
    }

    function getAnvilConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({ deployerKey: 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 });
    }

    function getSepoliaConfig() public view returns (NetworkConfig memory) {
        return NetworkConfig({ deployerKey: vm.envUint("PRIVATE_KEY") });
    }
}