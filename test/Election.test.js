const Election = artifacts.require("./Election.sol");

contract("Election", accounts => {
  it("name and two candidates should be set in the constructor", async () => {
    this.election = await Election.deployed();
    this.name = await this.election.nameoFElection.call();
    this.candidate1 = await this.election.candidates.call(0);
    this.candidate2 = await this.election.candidates.call(1);
    assert.equal(this.name, "Presidential Elections", "name was not expected");
  });

  // it("deploys successfully", async () => {
  //   const instance = await Election();
  // });
});
