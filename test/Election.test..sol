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

  function testNonOwnersCannotAuthorizeVoters() public {
    ThrowProxy proxy = new ThrowProxy(address(instance));
    Election(address(proxy)).authorize(this);
  }
}

//Proxy for catching exceptions
contract ThrowProxy {
  address public target;
  bytes data;

  function ThrowProxy(address _target){
    target = _target;
  }

  function(){
    data = msg.data;
  }

  function execute() returns (bool){
    return target.call(data);
  }
}