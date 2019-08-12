pragma solidity >=0.4.21 <0.6.0;

contract Ballot {
    uint public voteCount = 0;

     struct Voter {
        uint id;
        string name;
        bool voted;
  }

    struct Party {
        uint id;
        string name;
    }

  constructor() public {
        vote("You have successfully voted");
   }


  mapping(uint => Voter) public voters;
  mapping(uint => Party) public parties;

  function vote(string memory name) public {
    voteCount ++;
    parties[voteCount] = Party(voteCount, name);
    // emit VoterCreated(voteCount, _name, false);
  }
}