// supercoin_ico
pragma solidity^0.5.0;

contract supercoins_ico {
    uint public max_supercoins = 100000;
    uint public inr_to_supercoins = 1000;
    uint public total_supercoins_bought = 0;
    
    mapping(address => uint) equity_supercoins;
    mapping(address => uint) equity_inr;
    
    modifier can_buy_supercoins(uint inr_investing) {
        require (inr_investing * inr_to_supercoins + total_supercoins_bought <= max_supercoins);
        _;
    }
    
    function equity_in_supercoins(address investor) external view returns (uint){
        return equity_supercoins[investor];
    }
    
    function equity_in_inr (address investor) external view returns (uint) {
        return equity_inr[investor];
    }
    
    function buy_supercoins(address investor, uint inr_invested) external can_buy_supercoins(inr_invested) {
            uint supercoins_bought = inr_invested * inr_to_supercoins;
            equity_supercoins[investor] += supercoins_bought;
            equity_inr[investor] = equity_supercoins[investor] / 1000;
            total_supercoins_bought += supercoins_bought;
        }
        
     function sell_supercoins(address investor, uint supercoins_sold) external  {
           
            equity_supercoins[investor] -= supercoins_sold;
            equity_inr[investor] = equity_supercoins[investor] / 1000;
            total_supercoins_bought -= supercoins_sold;
        }
    
}