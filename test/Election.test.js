const Election = artifacts.require("./Election.sol");

contract("Election", accounts => {
  it("name should be set in the constructor", async () => {
    this.election = await Election.deployed();
    this.name = await this.election.nameoFElection.call();
    assert.equal(this.name, "Presidential Elections", "name was expected");
  });

  it("two candidates should be set in the constructor", async () => {
    this.election = await Election.deployed();
    this.candidate1 = await this.election.candidates.call(0);
    this.candidate2 = await this.election.candidates.call(1);
    assert.equal(this.candidate1[0], "Atiku", "it should be atiku");
    assert.equal(this.candidate2[0], "Buhari", "it must be buhari");
  });
});
