pragma solidity ^0.4.24;

contract ScottCoinSale {
  using SafeMath for uint256;

  TransferableToken public token;
  address public wallet;
  uint256 public rate;
  uint256 public totalRaised;

  constructor(address _token) public {
    rate = 1000000;
    token = TransferableToken(_token);
    wallet = msg.sender;
  }

  function() external payable {
    buyTokens(msg.sender);
  }

  function buyTokens(address _beneficiary) public payable {
    require(_beneficiary != address(0));
    require(msg.value != 0);

    uint256 tokens = msg.value.multiply(rate);
    totalRaised = totalRaised.add(msg.value);
    require(token.transfer(_beneficiary, tokens));
    emit TokenPurchase(msg.sender, _beneficiary, msg.value, tokens);
    wallet.transfer(msg.value);
  }

  event TokenPurchase(address indexed purchaser, address indexed beneficiary, uint256 value, uint256 amount);
}

library SafeMath {
  function add(uint256 _a, uint256 _b) internal pure returns (uint256) {
    uint256 c = _a + _b;
    require(c >= _a);
    return c;
  }

  function multiply(uint256 _a, uint256 _b) internal pure returns (uint256) {
    if (_a == 0) {
      return 0;
    }
    uint256 c = _a * _b;
    require(c / _a == _b);
    return c;
  }
}

contract TransferableToken {
  function transfer(address _to, uint256 _value) public returns (bool);
}