
# Aptos Move Basic Examples

Este repositorio contiene ejemplos básicos de **Move** en Aptos.  
Los módulos están diseñados como tutoriales prácticos para entender el lenguaje, sus estructuras de control, operaciones aritméticas y casos de uso financieros simples como un liquidity pool.

---

## Estructura

- `sources/`
  - **Sample1.move** → Constantes, Strings, Vectores y uso de `debug::print`.
  - **Sample2.move** → Constantes de dirección, uso de `bool`, módulos con `friend` y funciones de solo lectura (`#[view]`).
  - **Sample3.move** → Ejemplo de `friend` entre módulos dentro de un mismo `address`.
  - **Sample4.move** → Control de flujo:
    - `for`, `while`, `loop`
    - Uso de `abort` y `assert!` para manejo de errores.
  - **Sample5.move** → Operaciones aritméticas y de comparación:
    - ADD, SUB, MUL, DIV, MOD
    - Comparadores: `>`, `<`, `>=`, `<=`
  - **Sample6.move** → Operaciones bitwise y bitshift:
    - `|` OR, `&` AND, `^` XOR
    - `<<` Left Shift, `>>` Right Shift
  - **CastingDemo.move** → Conversiones entre `u64`, `u128` y ejemplo práctico de casting.
  - **Sample8.move** → Liquidity Pool Demo
    - Implementación simplificada de un AMM (x * y = k).
    - Cálculo de precio, swap con fee, y tests unitarios.

- `tests/`  
  Contiene pruebas unitarias asociadas a cada ejemplo (`#[test]`).

---

## Ejecución de Tests

Para correr todos los tests:

```bash
aptos move test
aptos move test --filter (funcion o por nommbre del smart contract) test_calculate_swap / Sample#
```

## Conceptos clave en los ejemplos

- Constantes: const con tipos explícitos (u64, address).

- Control de flujo: for, while, loop, break.

- Errores y validación: abort, assert! con códigos de error.

- Bitwise y Bitshift: manejo directo de bits.

- Casting: conversión explícita entre tipos enteros.

- Friends: compartir funciones privadas entre módulos del mismo address.

- Liquidity Pool: demo de un AMM aplicando fees y swaps.

## Notas de desarrollo 

- Estos ejemplos usan valores hardcoded (reservas, precios, fees).

- El Liquidity Pool no es seguro para producción, es únicamente didáctico.

- Para entornos reales se deben manejar Coin<T>, signer, storage global y protección contra slippage.




