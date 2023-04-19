// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

contract Random {
      
      uint256[20000] private array;
      uint256 public length = 20000;
      uint256 private randNum;

      function getRandom(uint256 salt) private returns(uint256) {
            require(length != 0,"Minting limit exceeds");
            uint256 rand = uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, salt)));
            uint256 randId = rand % length;
            if(array[randId] == 0)
                  randNum = randId;
            else
                  randNum = array[randId];       
            array[randId] =  array[length-1] == 0 ? length-1 : array[length-1];
            delete array[length-1];
            length--;
            return randNum;
      }

      function getnumber(uint256 salt) external returns(uint256[] memory){
            uint256[] memory result = new uint256[](10);
            for(uint256 i = 0; i<10; i++){
                  result[i] = getRandom(salt);
                 
                  if(result[i] == 0 )
                        result[i] = 20000;
                   salt +=1;
           
            }
            return result;
            
    }
}