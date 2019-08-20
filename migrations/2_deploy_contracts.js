const Election = artifacts.require("./Election.sol");

console.log(Election);

module.exports = function(deployer) {
  deployer.deploy(Election);
};
