module net2dev_addr::Sample4 {
    use std::debug::print;
    use std::string::{utf8, String};

    fun sample_for_loop(count: u64): u64 {
        let value = 0;
        for (i in 0..count) {
            value = value + 1;
        };
        value
    }

    fun sample_while_loop(count: u64): u64 {
        let value = 0;
        let i: u64 = 1;
        while (i <= count) {
            value = value + 1;
            i = i + 1;
        };
        value
    }

    fun sample_loop(count: u64): u64 {
        let value = 0;
        let i: u64 = 1; 
        loop {
            value = value + 1;
            i = i + 1;
            if(i > count) {
                break;
            };
        };
        value
    }

    fun sample_abort_error(value: String) {
        if(value == utf8(b"net2dev"))
            print(&utf8(b"Correct!"))
        else
            abort 123
    }

    fun sample_assert_error(value: String) {
        assert!(value == utf8(b"net2dev"), 123);
        print(&utf8(b"Correct!"))
    }

    #[test]
    fun test_for_loop() {
        let result = sample_for_loop(10);
        print(&result);
    }

    #[test]
    fun test_for_while() {
        let result = sample_while_loop(10);
        print(&result);
    }

    #[test]
    fun test_loop() {
        let result = sample_loop(10);
        print(&result);
    }

    #[test]
    #[expected_failure]
    fun test_abort_error() {
        sample_abort_error(utf8(b"net22dev"));
    }

    
    #[test]
    fun test_assert_error() {
        sample_abort_error(utf8(b"net2dev"));
    }


}