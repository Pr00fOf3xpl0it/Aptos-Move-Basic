module net2dev_addr::Sample5 {

    const ADD:  u64 = 0;
    const SUB:  u64 = 1;
    const MUL:  u64 = 2;
    const DIV:  u64 = 3;
    const MOD:  u64 = 4;

    fun arithmetic_operation(a: u64, b: u64, op: u64): u64 {
        if (op == ADD)
            return a + b
        else if(op == SUB)
            return a - b
        else if(op == MUL)
            return a * b
        else if(op == DIV)
            return a / b
        else 
            return a % b
    }
    
    #[test_only]
    use std::debug::print;

    #[test]
    fun test_arithmetic() {
        let result = arithmetic_operation(10, 20, ADD);
        print(&result)
    }

    // Equality Operations
    const HIGHER:  u64 = 0;
    const LOWER:  u64 = 1;
    const HIGHER_EQ:  u64 = 2;
    const LOWER_EQ:  u64 = 3;

    fun equality_operation(a: u64, b: u64, op: u64): bool {
        if (op == HIGHER)
            return a > b
        else if(op == LOWER)
            return a < b
        else if(op == HIGHER_EQ)
            return a >= b
        else 
            return a <= b
    }

    #[test]
    fun test_equality_operation() {
        let result = equality_operation(10, 5, HIGHER);
        print(&result)
    }
        

}