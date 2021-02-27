const Etheraffle = artifacts.require("Etheraffle");

module.exports = function(deployer) {
  deployer.deploy(Etheraffle, 100000000, 1000000000, 1616681778, false);
};
