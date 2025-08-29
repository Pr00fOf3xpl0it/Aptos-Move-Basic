address net2dev_addr {
    module one {
        friend net2dev_addr::two;
        friend net2dev_addr::three;

        public(friend) fun get_value(): u64 {
            return 100
        }

        #[view]
        public fun get_prices(): u64 {
            return 100
        }
    }

    module two {
        
        #[test_only]
        use std::debug::print;

        #[test]
        fun test_function() {
            let result = net2dev_addr::one::get_value();
            print(&result);
        }
    }

    module three {

        #[test_only]
        use std::debug::print;

        #[test]
        fun test_function() {
            let result = net2dev_addr::one::get_value();
            print(&result);
        }

    }
}