// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";

contract AVAXGods is ERC1155, Ownable, ERC1155Supply {
   string public baseURI;
   uint256 public totalSupply;
   uint256 public constant DEVIL = 0;
   uint256 public constant FIREBIRD = 2;
   uint256 public constant KAMO = 3;
   uint256 public constant KUKULKAN = 4;
   uint256 public constant CELESTION = 5;

   uint256 public constant MAX_ATTACK_DEFEND_STRENGTH = 10;

   enum BattleStatus { 
      PENDING, 
      STARTED, 
      ENDED 
   }

   struct GameToken {
      string name;
      uint256 id;
      uint256 atttackStrength;
      uint256 defenseStrength;
   }

   struct Player {
      address playerAddress;
      string playerName;
      uint256 playerMana;
      uint256 playerHealth;
      bool inBattle;
   }

   struct Battle {
      BattleStatus battleStatus;
      bytes32 battleHash;
      string name;
      address[2] players;
      uint8[2] moves;
      address winner;
   }

   mapping(address => uint256) public playerInfo;
   mapping(address => uint256) public playerTokenInfo;
   mapping(string => uint256) public battleInfo;

   Player[] public players;
   GameToken[] public gameTokens;
   Battle[] public battles;

   function isPlayer(address player) public view returns (bool){
      if(playerInfo[player] == 0){
         return false;
      }else{
         return true;
      }
   }

   function getPlayer(address player) public view returns (Player memory) {
      require(isPlayer(player), "Player doesn't exist!");
      return players[playerInfo[player]];
   }

   function getAllPlayers() public view returns (Player[] memory) {
      return players;
   }

   function isPlayerToken(address player) public view returns (bool) {
      if(playerTokenInfo[player] == 0){
         return false;
      } else {
         return true;
      }
   }

   function getAllPlayerTokens() public view returns (GameToken[] memory){
      return gameTokens;
   }

   function isBattle(string memory _name) public view returns (bool){
      if(battleInfo[_name] == 0){
         return false;
      }else{
         return true;
      }
   }

   function getBattle(string memory _name) public view returns (Battle memory){
      require(isBattle(_name), "Battle doesn't exist!");
      return battles[battleInfo[_name]];
   }

   function getAllBattles() public view returns (Battle[] memory){
      return battles;
   }

   function updateBattle(string memory _name, Battle memory _newBattle) private {
      require(isBattle(_name), "Battle doesn't exists");
      battles[battleInfo[_name]] = _newBattle;
   }

   event NewPlayer(address indexed owner, string name);
   event NewBattle(string battleName, address indexed player1, address indexed player2);
   event BattleEnded(string battleName, address indexed winner, address indexed loser);
   event BattleMove(string indexed battleName, bool indexed isFirstMove);
   event NewGameToken(address indexed owner, uint256 id, uint256 attackStrength, uint256 defenseStrength);
   event RoundEnded(address[2] damagedPlayers);

   constructor(string memory _metadataURI) ERC1155(_metadataURI){
      baseURI = _metadataURI;
   }
}

