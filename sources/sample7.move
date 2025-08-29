address net2dev_addr {

    module PriceOrable {

        public fun btc_price(): u128 {
            return 54200
        }


    }

    module CastingDemo {
        use net2dev_addr::PriceOrable;
        use std::debug::print;

        fun calculate_swap() {
            let price = PriceOrable::btc_price();
            let price_w_fee: u64 = (price as u64) + 5;
            let price_u128 = (price as u128);
            let cast_math = ((price_u128 as u64) + (price_u128 as u64)) as u128;
            print(&cast_math);
        }

        #[test]
        fun test_calculate_swap() {
            calculate_swap();
        }

    }


}
