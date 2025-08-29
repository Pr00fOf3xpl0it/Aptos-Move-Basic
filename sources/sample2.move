module net2dev_addr::Sample2 {

    const MY_ADDR: address = @net2dev_addr; // constantes tienen que comenzar con mayusculas

    fun config_value(choice: bool): (u64, bool) {
        if (choice)
            return (1, choice)
        else
            return (0, choice)
    }

    #[test_only]
    use std::debug::print;

}