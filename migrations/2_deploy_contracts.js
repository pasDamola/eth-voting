const Ballot = artifacts.require("./Ballot.sol");

console.log(Ballot);

module.exports = function(deployer) {
  deployer.deploy(Ballot, ['0xab', '0xac']);
};
