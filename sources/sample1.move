module net2dev_addr::Sample1 {
    use std::debug;
    use std::string::{String, utf8};

    const ID: u64 = 100; // u64 es un entero sin signo de 64 bits

    fun set_value(): u64 { // el : u64 es el tipo de retorno de la funcion
        let value_id: u64 = 200; // Declaracion de entero sin signo de 64 bits
        let string_val: String = utf8(b"net2dev"); // Declaracion de string b significa byte osea es un byte string
        let string_byte: vector<u8> = b"This is my byte value"; // Declaracion de vector de u8
        debug::print(&value_id); // Imprime el valor de value_id
        debug::print(&string_val);
        debug::print(&string_byte);
        debug::print(&utf8(string_byte));
        ID // Imprime el valor de ID
    }

    //Funciones test
    #[test]
    fun test_function() {
        let id_value = set_value();
        debug::print(&id_value);
    }
}