module net2dev_addr::Sample6 {

    /*
    
    | = OR 
    & = AND
    ^ = XOR
    */

    fun bitwise_or(a: u64, b: u64): u64 {
        return a | b
    }

    fun bitwise_and(a: u64, b: u64): u64 {
        return a & b
    }

    fun bitwise_xor(a: u64, b: u64): u64 {
        return a ^ b
    }
    #[test_only]
    use std::debug::print;

    #[test]
    fun test_bitwise() {
        let result = bitwise_or(10, 20);
        print(&result);
        let result = bitwise_and(10, 20);
        print(&result);
        let result = bitwise_xor(10, 20);
        print(&result);
    }

    /*
    Bitshift Operations
    << = Left Shift // Este operador mueve los bits a la izquierda
    >> = Right Shift // Este operador mueve los bits a la derecha
    */

    fun bitshift_left(a: u64, times: u8): u64 {
        return a << times
    }

    fun bitshift_right(a: u64, times: u8): u64 {
        return a >> times
    }

    #[test]

    fun test_bitshift() {
        let result = bitshift_left(7, 2);
        print(&result);
        let result = bitshift_right(7, 2);
        print(&result);
    }


}
