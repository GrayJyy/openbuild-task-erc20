// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    error HelperConfig__ChainIdNotSupported();

    struct NetworkConfig {
        uint256 deployerKey;
    }

    uint256 public constant DEFAULT_ANVIL_PRIVATE_KEY =
        0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    NetworkConfig public activeNetworkConfig;

    constructor() {
        if (block.chainid == 31337) {
            activeNetworkConfig = getOrCreateAnvilNetworkConfig();
        } else if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaNetworkConfig();
        } else {
            revert HelperConfig__ChainIdNotSupported();
        }
    }

    function getOrCreateAnvilNetworkConfig() internal view returns (NetworkConfig memory _anvilNetworkConfig) {
        // Check to see if we set an active network config
        if (activeNetworkConfig.deployerKey == DEFAULT_ANVIL_PRIVATE_KEY) {
            return activeNetworkConfig;
        }

        _anvilNetworkConfig = NetworkConfig({deployerKey: DEFAULT_ANVIL_PRIVATE_KEY});
    }

    function getSepoliaNetworkConfig() internal view returns (NetworkConfig memory _sepoliaNotworkConfig) {
        _sepoliaNotworkConfig = NetworkConfig({deployerKey: vm.envUint("PRIVATE_KEY")});
    }
}
