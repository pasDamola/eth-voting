pragma solidity >=0.4.0 <0.7.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Election.sol";

contract TestElection {
  Election instance = Election(DeloyedAddresses.Election());

  function testNonAuthorizedVoteDoesNotCount() public {
    uint preVoteCount;

    (, preVoteCount) = instance.candidates(0);

    instance.vote(0);

    var(, postVoteCount) = instance.candidates(0);
    Assert.equal(preVoteCount, postVoteCount, "preVoteCount should be the same as postVoteCount")

  }
}