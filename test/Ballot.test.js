const Ballot = artifacts.require("./Ballot.sol");

contract("Ballot", accounts => {
  before(async () => {
    this.ballot = await Ballot.deployed();
  });

  it("deploys successfully", async () => {
    const instance = await Ballot();
  });
});
