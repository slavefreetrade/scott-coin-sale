var Migrations = artifacts.require("./Migrations.sol");
var ScottCoinSale = artifacts.require("./ScottCoinSale.sol");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(ScottCoinSale, '0x1e2025e0a91df6e47867a3e52299cad71fe1a9db');
};
