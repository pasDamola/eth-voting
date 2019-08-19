pragma solidity >=0.4.21 <0.6.0;

contract Ballot {
   uint256 counter;
   address owner;

   constructor() public {
     counter = 0;
     owner = msg.sender;
   }

   function getCounter() public view returns(uint256){
     return counter;
   }
   
   function increment() public {
     counter++;
   }

   function decrement() public {
     counter--;
   }

   function reset() public {
     require(msg.sender == owner, "You have no right to do this");
     counter = 0;
   }

}