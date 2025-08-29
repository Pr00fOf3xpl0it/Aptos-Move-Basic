module net2dev_addr::Sample8 {

    /*
    ============================================================================
    Liquidity Pool (USDT <-> N2DR)
    ============================================================================

    @title   Constant Product AMM Example
    @notice  Simulación de swap: 495 USDT a N2DR con fee del 5% (modelo x*y = k).

    ---------------------------------------------------------------------------
    Contexto / Estado inicial
    ---------------------------------------------------------------------------
    - Coin1 = 3201 USDT
    - Coin2 =  312 N2DR

    ---------------------------------------------------------------------------
    Desglose del cálculo (tal cual tu especificación)
    ---------------------------------------------------------------------------

    Value1 - Aplicar fee 0.5%
        Fee = (495 * 5) / 1000 = 2

    Value2 - Producto constante (x * y = k)
        MixSup = 3201 * 312 = 998,712

    Value3 - Nuevo reserve de USDT tras el swap
        NewUSDT = 3201 + 495 = 3696

    Value4 - Nuevo reserve de N2DR tras el swap
        NewN2DR = MixSup / (NewUSDT - fee) = 270

    Value5 - N2DR a transferir al usuario
        Transfer = 312 - 270 = 42

    ---------------------------------------------------------------------------
    Result
    ---------------------------------------------------------------------------
    Usuario envía: 495 USDT
    Usuario recibe: ~42 N2DR

    ---------------------------------------------------------------------------
    DEV Notes
    ---------------------------------------------------------------------------
    - Invariante AMM: k = x * y debe mantenerse (salvo redondeo entero).
    - Las divisiones son truncadas (u64), puede haber redondeo a la baja.
    - Los asserts abortan la transacción con códigos de error si fallan.
    - Este ejemplo usa fee fijo y reservas “hardcoded” para demo/testing.

    TODO:
    - Parametrizar el fee (basis points) y validar límites.
    - Extraer el cálculo a una librería reusable para distintos pools.
    - Manejar rounding/skim si se requiere exactitud contable por tokenomics.

    ============================================================================
    */

    use std::string::{String, utf8};

    // ------------------------------------------------------------------------
    // Códigos de error
    // ------------------------------------------------------------------------
    const E_NOTENOUGH: u64 = 0;

    // ------------------------------------------------------------------------
    // Identificadores simbólicos y reservas de ejemplo (demo)
    // ------------------------------------------------------------------------
    const N2DR: u64 = 1;
    const APT:  u64 = 2;
    const WETH: u64 = 3;

    const Pool1_n2dr: u64 = 312;
    const Pool1_usdt: u64 = 3201;
    const N2DR_name: vector<u8> = b"N2DR Rewards";

    const Pool2_apt:  u64 = 21500;
    const Pool2_usdt: u64 = 124700;
    const APT_name: vector<u8>  = b"APT";

    const Pool3_weth: u64 = 1310;
    const Pool3_usdt: u64 = 2750000;
    const WETH_name: vector<u8> = b"WETH";

    /// @notice Devuelve reservas y nombre según el símbolo.
    /// @dev Para demo: valores fijos. En prod, leer de storage del pool.
    /// @param coin_symbol Identificador del activo base del pool.
    /// @return (coin_reserve, usdt_reserve, name)
    fun get_supply(coin_symbol: u64): (u64, u64, vector<u8>) {
        if (coin_symbol == N2DR) {
            return (Pool1_n2dr, Pool1_usdt, N2DR_name)
        } else if (coin_symbol == APT) {
            return (Pool2_apt, Pool2_usdt, APT_name)
        } else {
            return (Pool3_weth, Pool3_usdt, WETH_name)
        }
    }

    /// @notice Calcula precio como razón coin1/coin2.
    /// @dev Requiere reservas positivas para evitar división por cero.
    /// @param coin1 Numerador (p.ej., USDT).
    /// @param coin2 Denominador (p.ej., N2DR).
    /// @return price Precio entero truncado.
    fun token_price(coin1: u64, coin2: u64): u64 {
        assert!(coin1 > 0, E_NOTENOUGH);
        assert!(coin2 > 0, E_NOTENOUGH);
        coin1 / coin2
    }

    /// @notice Calcula el output del swap con fee (modelo x*y=k).
    /// @dev
    /// - Mantiene invariante k = coin1 * coin2.
    /// - Aplica fee sobre el input (basis = 1000 → 5 = 0.5%, 50 = 5%, etc.).
    /// - División entera con truncamiento; posible “dust”.
    ///
    /// Fórmula equivalente (con net_in = coin1_amt - fee):
    ///     new_coin1 = coin1 + coin1_amt
    ///     new_coin2 = (coin1 * coin2) / (new_coin1 - fee)
    ///     receive   = coin2 - new_coin2
    ///
    /// @param coin1       Reserva actual del token 1 (p.ej., USDT).
    /// @param coin2       Reserva actual del token 2 (p.ej., N2DR).
    /// @param coin1_amt   Monto de token1 que entra al pool (input bruto).
    /// @return receive    Cantidad de token2 entregada al usuario.
    fun calculate_swap(coin1: u64, coin2: u64, coin1_amt: u64): u64 {
        assert!(coin1_amt > 0, E_NOTENOUGH);

        // Fee expresado en milésimas (aquí 5 => 0.5%, 50 => 5%).
        // NOTA: tu especificación dice 5% con 5/1000 (=0.5%). Conservamos tu fórmula:
        let fee = coin1_amt * 5 / 1000;

        let mix_supply: u64 = coin1 * coin2;              // k = x*y
        let new_usdt: u64 = coin1 + coin1_amt;            // x'
        let new_n2dr: u64 = mix_supply / (new_usdt - fee); // y' = k / (x' - fee)
        let receive: u64 = coin2 - new_n2dr;              // Δy

        receive
    }

    // ------------------------------------------------------------------------
    // Tests
    // ------------------------------------------------------------------------
    #[test_only]
    use std::debug::print;

    /// @notice Test de flujo completo: precio antes/después y swap.
    /// @dev Útil para validar que k≈const (considerando truncamiento).
    #[test]
    fun test_calculate_swap() {
        let (coin1, coin2, name) = get_supply(N2DR);
        let swap_amount = 495; // USDT to swap

        print(&utf8(b"Swap USDT for:"));
        print(&utf8(name));

        print(&utf8(b"Token price before swap:"));
        let price_before = token_price(coin1, coin2);
        print(&price_before);

        let result = calculate_swap(coin1, coin2, swap_amount);
        print(&result);

        print(&utf8(b"Token price after swap:"));
        let coin1_after = coin1 + swap_amount;
        let coin2_after = coin2 - result;
        let price_after = token_price(coin1_after, coin2_after);
        print(&price_after);

    }
}

