pragma solidity ^0.4.17;

contract Lottery{
    address public manager;
    address[] public players;


    function Lottery() public {
        manager = msg.sender;
    }

    function enter() public payable{
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }



    function random() private returns(uint){
        return uint (keccak256(players,block.timestamp,block.difficulty));
    }

    function pickWinner() public {
        uint index = random() % players.length;
        players[index].transfer(this.balance);
    }

}