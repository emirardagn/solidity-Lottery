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



    function random() private view returns(uint){
        return uint (keccak256(players,block.timestamp,block.difficulty));
    }

    function pickWinner() public admin {
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0);
    }

    modifier admin() {
       require(msg.sender == manager);
       _;
    }

}