// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {OBC} from "../src/OBC.sol";

contract DeployOBC is Script {
    constructor() {}

    function run() external returns (OBC obc, HelperConfig helperConfig) {
        helperConfig = new HelperConfig();
        (uint256 deployerKey) = helperConfig.activeNetworkConfig();
        console.log("strating deploy on chainid: %s", block.chainid);
        vm.startBroadcast(deployerKey);
        obc = new OBC("OBC", "OB");
        vm.stopBroadcast();
        console.log("deployed OBC at: %s", address(obc));
    }
}
