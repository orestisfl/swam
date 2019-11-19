;; Test all the bitwise operators on major boundary values and all special values.

(module
  (func (export "not") (param $0 v128) (result v128) (v128.not (local.get $0)))
  (func (export "and") (param $0 v128) (param $1 v128) (result v128) (v128.and (local.get $0) (local.get $1)))
  (func (export "or") (param $0 v128) (param $1 v128) (result v128) (v128.or (local.get $0) (local.get $1)))
  (func (export "xor") (param $0 v128) (param $1 v128) (result v128) (v128.xor (local.get $0) (local.get $1)))
  (func (export "bitselect") (param $0 v128) (param $1 v128) (param $2 v128) (result v128)
    (v128.bitselect (local.get $0) (local.get $1) (local.get $2))
  )
  (func (export "andnot") (param $0 v128) (param $1 v128) (result v128) (v128.andnot (local.get $0) (local.get $1)))
)

;; i32x4
(assert_return (invoke "not" (v128.const i32x4 0 0 0 0))
                             (v128.const i32x4 -1 -1 -1 -1))
(assert_return (invoke "not" (v128.const i32x4 -1 -1 -1 -1))
                             (v128.const i32x4 0 0 0 0))
(assert_return (invoke "not" (v128.const i32x4 -1 0 -1 0))
                             (v128.const i32x4 0 -1 0 -1))
(assert_return (invoke "not" (v128.const i32x4 0 -1 0 -1))
                             (v128.const i32x4 -1 0 -1 0))
(assert_return (invoke "not" (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555))
                             (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA))
(assert_return (invoke "not" (v128.const i32x4 3435973836 3435973836 3435973836 3435973836))
                             (v128.const i32x4 858993459 858993459 858993459 858993459))
(assert_return (invoke "and" (v128.const i32x4 0 0 -1 -1)
                             (v128.const i32x4 0 -1 0 -1))
                             (v128.const i32x4 0 0 0 -1))
(assert_return (invoke "and" (v128.const i32x4 0 0 0 0)
                             (v128.const i32x4 0 0 0 0))
                             (v128.const i32x4 0 0 0 0))
(assert_return (invoke "and" (v128.const i32x4 0 0 0 0)
                             (v128.const i32x4 -1 -1 -1 -1))
                             (v128.const i32x4 0 0 0 0))
(assert_return (invoke "and" (v128.const i32x4 0 0 0 0)
                             (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF))
                             (v128.const i32x4 0 0 0 0))
(assert_return (invoke "and" (v128.const i32x4 1 1 1 1)
                             (v128.const i32x4 1 1 1 1))
                             (v128.const i32x4 1 1 1 1))
(assert_return (invoke "and" (v128.const i32x4 255 255 255 255)
                             (v128.const i32x4 85 85 85 85))
                             (v128.const i32x4 85 85 85 85))
(assert_return (invoke "and" (v128.const i32x4 255 255 255 255)
                             (v128.const i32x4 128 128 128 128))
                             (v128.const i32x4 128 128 128 128))
(assert_return (invoke "and" (v128.const i32x4 2863311530 2863311530 2863311530 2863311530)
                             (v128.const i32x4 10 128 5 165))
                             (v128.const i32x4 10 128 0 160))
(assert_return (invoke "and" (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)
                             (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555))
                             (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555))
(assert_return (invoke "and" (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)
                             (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA))
                             (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA))
(assert_return (invoke "and" (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)
                             (v128.const i32x4 0x0 0x0 0x0 0x0))
                             (v128.const i32x4 0x0 0x0 0x0 0x0))
(assert_return (invoke "and" (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555)
                             (v128.const i32x4 0x5555 0xFFFF 0x55FF 0x5FFF))
                             (v128.const i32x4 0x5555 0x5555 0x5555 0x5555))
(assert_return (invoke "or" (v128.const i32x4 0 0 -1 -1)
                            (v128.const i32x4 0 -1 0 -1))
                            (v128.const i32x4 0 -1 -1 -1))
(assert_return (invoke "or" (v128.const i32x4 0 0 0 0)
                            (v128.const i32x4 0 0 0 0))
                            (v128.const i32x4 0 0 0 0))
(assert_return (invoke "or" (v128.const i32x4 0 0 0 0)
                            (v128.const i32x4 -1 -1 -1 -1))
                            (v128.const i32x4 -1 -1 -1 -1))
(assert_return (invoke "or" (v128.const i32x4 0 0 0 0)
                            (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF))
                            (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF))
(assert_return (invoke "or" (v128.const i32x4 1 1 1 1)
                            (v128.const i32x4 1 1 1 1))
                            (v128.const i32x4 1 1 1 1))
(assert_return (invoke "or" (v128.const i32x4 255 255 255 255)
                            (v128.const i32x4 85 85 85 85))
                            (v128.const i32x4 255 255 255 255))
(assert_return (invoke "or" (v128.const i32x4 255 255 255 255)
                            (v128.const i32x4 128 128 128 128))
                            (v128.const i32x4 255 255 255 255))
(assert_return (invoke "or" (v128.const i32x4 2863311530 2863311530 2863311530 2863311530)
                            (v128.const i32x4 10 128 5 165))
                            (v128.const i32x4 2863311530 2863311530 2863311535 2863311535))
(assert_return (invoke "or" (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)
                            (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555))
                            (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF))
(assert_return (invoke "or" (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)
                            (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA))
                            (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF))
(assert_return (invoke "or" (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)
                            (v128.const i32x4 0x0 0x0 0x0 0x0))
                            (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF))
(assert_return (invoke "or" (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555)
                            (v128.const i32x4 0x5555 0xFFFF 0x55FF 0x5FFF))
                            (v128.const i32x4 0x55555555 0x5555ffff 0x555555ff 0x55555fff))
(assert_return (invoke "xor" (v128.const i32x4 0 0 -1 -1)
                             (v128.const i32x4 0 -1 0 -1))
                             (v128.const i32x4 0 -1 -1 0))
(assert_return (invoke "xor" (v128.const i32x4 0 0 0 0)
                             (v128.const i32x4 0 0 0 0))
                             (v128.const i32x4 0 0 0 0))
(assert_return (invoke "xor" (v128.const i32x4 0 0 0 0)
                             (v128.const i32x4 -1 -1 -1 -1))
                             (v128.const i32x4 -1 -1 -1 -1))
(assert_return (invoke "xor" (v128.const i32x4 0 0 0 0)
                             (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF))
                             (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF))
(assert_return (invoke "xor" (v128.const i32x4 1 1 1 1)
                             (v128.const i32x4 1 1 1 1))
                             (v128.const i32x4 0 0 0 0))
(assert_return (invoke "xor" (v128.const i32x4 255 255 255 255)
                             (v128.const i32x4 85 85 85 85))
                             (v128.const i32x4 170 170 170 170))
(assert_return (invoke "xor" (v128.const i32x4 255 255 255 255)
                             (v128.const i32x4 128 128 128 128))
                             (v128.const i32x4 127 127 127 127))
(assert_return (invoke "xor" (v128.const i32x4 2863311530 2863311530 2863311530 2863311530)
                             (v128.const i32x4 10 128 5 165))
                             (v128.const i32x4 2863311520 2863311402 2863311535 2863311375))
(assert_return (invoke "xor" (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)
                             (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555))
                             (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA))
(assert_return (invoke "xor" (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)
                             (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA))
                             (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555))
(assert_return (invoke "xor" (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)
                             (v128.const i32x4 0x0 0x0 0x0 0x0))
                             (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF))
(assert_return (invoke "xor" (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555)
                             (v128.const i32x4 0x5555 0xFFFF 0x55FF 0x5FFF))
                             (v128.const i32x4 0x55550000 0x5555AAAA 0x555500AA 0x55550AAA))
(assert_return (invoke "bitselect" (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA)
                                   (v128.const i32x4 0xBBBBBBBB 0xBBBBBBBB 0xBBBBBBBB 0xBBBBBBBB)
                                   (v128.const i32x4 0x00112345 0xF00FFFFF 0x10112021 0xBBAABBAA))
                                   (v128.const i32x4 0xBBAABABA 0xABBAAAAA 0xABAABBBA 0xAABBAABB))
(assert_return (invoke "bitselect" (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA)
                                   (v128.const i32x4 0xBBBBBBBB 0xBBBBBBBB 0xBBBBBBBB 0xBBBBBBBB)
                                   (v128.const i32x4 0x00000000 0x00000000 0x00000000 0x00000000))
                                   (v128.const i32x4 0xBBBBBBBB 0xBBBBBBBB 0xBBBBBBBB 0xBBBBBBBB))
(assert_return (invoke "bitselect" (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA)
                                   (v128.const i32x4 0xBBBBBBBB 0xBBBBBBBB 0xBBBBBBBB 0xBBBBBBBB)
                                   (v128.const i32x4 0x11111111 0x11111111 0x11111111 0x11111111))
                                   (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA))
(assert_return (invoke "bitselect" (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA)
                                   (v128.const i32x4 0xBBBBBBBB 0xBBBBBBBB 0xBBBBBBBB 0xBBBBBBBB)
                                   (v128.const i32x4 0x01234567 0x89ABCDEF 0xFEDCBA98 0x76543210))
                                   (v128.const i32x4 0xBABABABA 0xBABABABA 0xABABABAB 0xABABABAB))
(assert_return (invoke "bitselect" (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA)
                                   (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555)
                                   (v128.const i32x4 0x01234567 0x89ABCDEF 0xFEDCBA98 0x76543210))
                                   (v128.const i32x4 0x54761032 0xDCFE98BA 0xAB89EFCD 0x23016745))
(assert_return (invoke "bitselect" (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA)
                                   (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555)
                                   (v128.const i32x4 0x55555555 0xAAAAAAAA 0x00000000 0xFFFFFFFF))
                                   (v128.const i32x4 0x00000000 0xFFFFFFFF 0x55555555 0xAAAAAAAA))
(assert_return (invoke "andnot" (v128.const i32x4 0 0 -1 -1)
                                (v128.const i32x4 0 -1 0 -1))
                                (v128.const i32x4 0 0 -1 0))
(assert_return (invoke "andnot" (v128.const i32x4 0 0 0 0)
                                (v128.const i32x4 0 0 0 0))
                                (v128.const i32x4 0 0 0 0))
(assert_return (invoke "andnot" (v128.const i32x4 0 0 0 0)
                                (v128.const i32x4 -1 -1 -1 -1))
                                (v128.const i32x4 0 0 0 0))
(assert_return (invoke "andnot" (v128.const i32x4 0 0 0 0)
                                (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF))
                                (v128.const i32x4 0 0 0 0))
(assert_return (invoke "andnot" (v128.const i32x4 1 1 1 1)
                                (v128.const i32x4 1 1 1 1))
                                (v128.const i32x4 0 0 0 0))
(assert_return (invoke "andnot" (v128.const i32x4 255 255 255 255)
                                (v128.const i32x4 85 85 85 85))
                                (v128.const i32x4 170 170 170 170))
(assert_return (invoke "andnot" (v128.const i32x4 255 255 255 255)
                                (v128.const i32x4 128 128 128 128))
                                (v128.const i32x4 127 127 127 127))
(assert_return (invoke "andnot" (v128.const i32x4 2863311530 2863311530 2863311530 2863311530)
                                (v128.const i32x4 10 128 5 165))
                                (v128.const i32x4 2863311520 2863311402 2863311530 2863311370))
(assert_return (invoke "andnot" (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)
                                (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555))
                                (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA))
(assert_return (invoke "andnot" (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)
                                (v128.const i32x4 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA 0xAAAAAAAA))
                                (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555))
(assert_return (invoke "andnot" (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF)
                                (v128.const i32x4 0x0 0x0 0x0 0x0))
                                (v128.const i32x4 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF))
(assert_return (invoke "andnot" (v128.const i32x4 0x55555555 0x55555555 0x55555555 0x55555555)
                                (v128.const i32x4 0x5555 0xFFFF 0x55FF 0x5FFF))
                                (v128.const i32x4 0x55550000 0x55550000 0x55550000 0x55550000))

;; for float special data [e.g. -nan nan -inf inf]
(assert_return (invoke "not" (v128.const f32x4 -nan -nan -nan -nan))
                             (v128.const f32x4 5.87747e-39 5.87747e-39 5.87747e-39 5.87747e-39))
(assert_return (invoke "not" (v128.const f32x4 nan nan nan nan))
                             (v128.const f32x4 -5.87747e-39 -5.87747e-39 -5.87747e-39 -5.87747e-39))
(assert_return (invoke "not" (v128.const f32x4 -inf -inf -inf -inf))
                             (v128.const i32x4 0x007fffff 0x007fffff 0x007fffff 0x007fffff))
(assert_return (invoke "not" (v128.const f32x4 inf inf inf inf))
                             (v128.const i32x4 0x807fffff 0x807fffff 0x807fffff 0x807fffff))
(assert_return (invoke "and" (v128.const f32x4 -nan -nan -nan -nan)
                             (v128.const f32x4 -nan -nan -nan -nan))
                             (v128.const i32x4 0xffc00000 0xffc00000 0xffc00000 0xffc00000))
(assert_return (invoke "and" (v128.const f32x4 -nan -nan -nan -nan)
                             (v128.const f32x4 nan nan nan nan))
                             (v128.const f32x4 nan nan nan nan))
(assert_return (invoke "and" (v128.const f32x4 -nan -nan -nan -nan)
                             (v128.const f32x4 -inf -inf -inf -inf))
                             (v128.const f32x4 -inf -inf -inf -inf))
(assert_return (invoke "and" (v128.const f32x4 -nan -nan -nan -nan)
                             (v128.const f32x4 inf inf inf inf))
                             (v128.const f32x4 inf inf inf inf))
(assert_return (invoke "and" (v128.const f32x4 nan nan nan nan)
                             (v128.const f32x4 nan nan nan nan))
                             (v128.const f32x4 nan nan nan nan))
(assert_return (invoke "and" (v128.const f32x4 nan nan nan nan)
                             (v128.const f32x4 -inf -inf -inf -inf))
                             (v128.const f32x4 inf inf inf inf))
(assert_return (invoke "and" (v128.const f32x4 nan nan nan nan)
                             (v128.const f32x4 inf inf inf inf))
                             (v128.const f32x4 inf inf inf inf))
(assert_return (invoke "and" (v128.const f32x4 -inf -inf -inf -inf)
                             (v128.const f32x4 -inf -inf -inf -inf))
                             (v128.const f32x4 -inf -inf -inf -inf))
(assert_return (invoke "and" (v128.const f32x4 -inf -inf -inf -inf)
                             (v128.const f32x4 inf inf inf inf))
                             (v128.const f32x4 inf inf inf inf))
(assert_return (invoke "and" (v128.const f32x4 inf inf inf inf)
                             (v128.const f32x4 inf inf inf inf))
                             (v128.const f32x4 inf inf inf inf))
(assert_return (invoke "or" (v128.const f32x4 -nan -nan -nan -nan)
                            (v128.const f32x4 -nan -nan -nan -nan))
                            (v128.const i32x4 0xffc00000 0xffc00000 0xffc00000 0xffc00000))
(assert_return (invoke "or" (v128.const f32x4 -nan -nan -nan -nan)
                            (v128.const f32x4 nan nan nan nan))
                            (v128.const i32x4 0xffc00000 0xffc00000 0xffc00000 0xffc00000))
(assert_return (invoke "or" (v128.const f32x4 -nan -nan -nan -nan)
                            (v128.const f32x4 -inf -inf -inf -inf))
                            (v128.const i32x4 0xffc00000 0xffc00000 0xffc00000 0xffc00000))
(assert_return (invoke "or" (v128.const f32x4 -nan -nan -nan -nan)
                            (v128.const f32x4 inf inf inf inf))
                            (v128.const i32x4 0xffc00000 0xffc00000 0xffc00000 0xffc00000))
(assert_return (invoke "or" (v128.const f32x4 nan nan nan nan)
                            (v128.const f32x4 nan nan nan nan))
                            (v128.const f32x4 nan nan nan nan))
(assert_return (invoke "or" (v128.const f32x4 nan nan nan nan)
                            (v128.const f32x4 -inf -inf -inf -inf))
                            (v128.const i32x4 0xffc00000 0xffc00000 0xffc00000 0xffc00000))
(assert_return (invoke "or" (v128.const f32x4 nan nan nan nan)
                            (v128.const f32x4 inf inf inf inf))
                            (v128.const f32x4 nan nan nan nan))
(assert_return (invoke "or" (v128.const f32x4 -inf -inf -inf -inf)
                            (v128.const f32x4 -inf -inf -inf -inf))
                            (v128.const f32x4 -inf -inf -inf -inf))
(assert_return (invoke "or" (v128.const f32x4 -inf -inf -inf -inf)
                            (v128.const f32x4 inf inf inf inf))
                            (v128.const f32x4 -inf -inf -inf -inf))
(assert_return (invoke "or" (v128.const f32x4 inf inf inf inf)
                            (v128.const f32x4 inf inf inf inf))
                            (v128.const f32x4 inf inf inf inf))
(assert_return (invoke "xor" (v128.const f32x4 -nan -nan -nan -nan)
                             (v128.const f32x4 -nan -nan -nan -nan))
                             (v128.const f32x4 0 0 0 0))
(assert_return (invoke "xor" (v128.const f32x4 -nan -nan -nan -nan)
                             (v128.const f32x4 nan nan nan nan))
                             (v128.const f32x4 -0 -0 -0 -0))
(assert_return (invoke "xor" (v128.const f32x4 -nan -nan -nan -nan)
                             (v128.const f32x4 -inf -inf -inf -inf))
                             (v128.const i32x4 0x00400000 0x00400000 0x00400000 0x00400000))
(assert_return (invoke "xor" (v128.const f32x4 -nan -nan -nan -nan)
                             (v128.const f32x4 inf inf inf inf))
                             (v128.const i32x4 0x80400000 0x80400000 0x80400000 0x80400000))
(assert_return (invoke "xor" (v128.const f32x4 nan nan nan nan)
                             (v128.const f32x4 nan nan nan nan))
                             (v128.const f32x4 0 0 0 0))
(assert_return (invoke "xor" (v128.const f32x4 nan nan nan nan)
                             (v128.const f32x4 -inf -inf -inf -inf))
                             (v128.const i32x4 0x80400000 0x80400000 0x80400000 0x80400000))
(assert_return (invoke "xor" (v128.const f32x4 nan nan nan nan)
                             (v128.const f32x4 inf inf inf inf))
                             (v128.const i32x4 0x00400000 0x00400000 0x00400000 0x00400000))
(assert_return (invoke "xor" (v128.const f32x4 -inf -inf -inf -inf)
                             (v128.const f32x4 -inf -inf -inf -inf))
                             (v128.const f32x4 0 0 0 0))
(assert_return (invoke "xor" (v128.const f32x4 -inf -inf -inf -inf)
                             (v128.const f32x4 inf inf inf inf))
                             (v128.const i32x4 0x80000000 0x80000000 0x80000000 0x80000000))
(assert_return (invoke "xor" (v128.const f32x4 inf inf inf inf)
                             (v128.const f32x4 inf inf inf inf))
                             (v128.const f32x4 0 0 0 0))
(assert_return (invoke "bitselect" (v128.const f32x4 -nan -nan -nan -nan)
                                   (v128.const f32x4 -nan -nan -nan -nan)
                                   (v128.const f32x4 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5))
                                   (v128.const i32x4 0xffc00000 0xffc00000 0xffc00000 0xffc00000))
(assert_return (invoke "bitselect" (v128.const f32x4 -nan -nan -nan -nan)
                                   (v128.const f32x4 nan nan nan nan)
                                   (v128.const f32x4 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5))
                                   (v128.const f32x4 nan nan nan nan))
(assert_return (invoke "bitselect" (v128.const f32x4 -nan -nan -nan -nan)
                                   (v128.const f32x4 -inf -inf -inf -inf)
                                   (v128.const f32x4 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5))
                                   (v128.const f32x4 -inf -inf -inf -inf))
(assert_return (invoke "bitselect" (v128.const f32x4 -nan -nan -nan -nan)
                                   (v128.const f32x4 inf inf inf inf)
                                   (v128.const f32x4 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5))
                                   (v128.const f32x4 inf inf inf inf))
(assert_return (invoke "bitselect" (v128.const f32x4 nan nan nan nan)
                                   (v128.const f32x4 nan nan nan nan)
                                   (v128.const f32x4 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5))
                                   (v128.const f32x4 nan nan nan nan))
(assert_return (invoke "bitselect" (v128.const f32x4 nan nan nan nan)
                                   (v128.const f32x4 -inf -inf -inf -inf)
                                   (v128.const f32x4 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5))
                                   (v128.const f32x4 -inf -inf -inf -inf))
(assert_return (invoke "bitselect" (v128.const f32x4 nan nan nan nan)
                                   (v128.const f32x4 inf inf inf inf)
                                   (v128.const f32x4 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5))
                                   (v128.const f32x4 inf inf inf inf))
(assert_return (invoke "bitselect" (v128.const f32x4 -inf -inf -inf -inf)
                                   (v128.const f32x4 -inf -inf -inf -inf)
                                   (v128.const f32x4 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5))
                                   (v128.const f32x4 -inf -inf -inf -inf))
(assert_return (invoke "bitselect" (v128.const f32x4 -inf -inf -inf -inf)
                                   (v128.const f32x4 inf inf inf inf)
                                   (v128.const f32x4 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5))
                                   (v128.const f32x4 inf inf inf inf))
(assert_return (invoke "bitselect" (v128.const f32x4 inf inf inf inf)
                                   (v128.const f32x4 inf inf inf inf)
                                   (v128.const f32x4 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5 0xA5A5A5A5))
                                   (v128.const f32x4 inf inf inf inf))
(assert_return (invoke "andnot" (v128.const f32x4 -nan -nan -nan -nan)
                                (v128.const f32x4 -nan -nan -nan -nan))
                                (v128.const i32x4 0x00000000 0x00000000 0x00000000 0x00000000))
(assert_return (invoke "andnot" (v128.const f32x4 -nan -nan -nan -nan)
                                (v128.const f32x4 nan nan nan nan))
                                (v128.const f32x4 -0 -0 -0 -0))
(assert_return (invoke "andnot" (v128.const f32x4 -nan -nan -nan -nan)
                                (v128.const f32x4 -inf -inf -inf -inf))
                                (v128.const i32x4 0x00400000 0x00400000 0x00400000 0x00400000))
(assert_return (invoke "andnot" (v128.const f32x4 -nan -nan -nan -nan)
                                (v128.const f32x4 inf inf inf inf))
                                (v128.const i32x4 0x80400000 0x80400000 0x80400000 0x80400000))
(assert_return (invoke "andnot" (v128.const f32x4 nan nan nan nan)
                                (v128.const f32x4 nan nan nan nan))
                                (v128.const f32x4 0x00000000 0x00000000 0x00000000 0x00000000))
(assert_return (invoke "andnot" (v128.const f32x4 nan nan nan nan)
                                (v128.const f32x4 -inf -inf -inf -inf))
                                (v128.const i32x4 0x00400000 0x00400000 0x00400000 0x00400000))
(assert_return (invoke "andnot" (v128.const f32x4 nan nan nan nan)
                                (v128.const f32x4 inf inf inf inf))
                                (v128.const i32x4 0x00400000 0x00400000 0x00400000 0x00400000))
(assert_return (invoke "andnot" (v128.const f32x4 -inf -inf -inf -inf)
                                (v128.const f32x4 -inf -inf -inf -inf))
                                (v128.const f32x4 0x00000000 0x00000000 0x00000000 0x00000000))
(assert_return (invoke "andnot" (v128.const f32x4 -inf -inf -inf -inf)
                                (v128.const f32x4 inf inf inf inf))
                                (v128.const i32x4 0x80000000 0x80000000 0x80000000 0x80000000))
(assert_return (invoke "andnot" (v128.const f32x4 inf inf inf inf)
                                (v128.const f32x4 inf inf inf inf))
                                (v128.const i32x4 0x00000000 0x00000000 0x00000000 0x00000000))

;; Type check

;; not
(assert_invalid (module (func (result v128) (v128.not (i32.const 0)))) "type mismatch")
;; and
(assert_invalid (module (func (result v128) (v128.and (i32.const 0) (v128.const i32x4 0 0 0 0)))) "type mismatch")
(assert_invalid (module (func (result v128) (v128.and (v128.const i32x4 0 0 0 0) (i32.const 0)))) "type mismatch")
(assert_invalid (module (func (result v128) (v128.and (i32.const 0) (i32.const 0)))) "type mismatch")
;; or
(assert_invalid (module (func (result v128) (v128.or (i32.const 0) (v128.const i32x4 0 0 0 0)))) "type mismatch")
(assert_invalid (module (func (result v128) (v128.or (v128.const i32x4 0 0 0 0) (i32.const 0)))) "type mismatch")
(assert_invalid (module (func (result v128) (v128.or (i32.const 0) (i32.const 0)))) "type mismatch")
;; xor
(assert_invalid (module (func (result v128) (v128.xor (i32.const 0) (v128.const i32x4 0 0 0 0)))) "type mismatch")
(assert_invalid (module (func (result v128) (v128.xor (v128.const i32x4 0 0 0 0) (i32.const 0)))) "type mismatch")
(assert_invalid (module (func (result v128) (v128.xor (i32.const 0) (i32.const 0)))) "type mismatch")
;; bitselect
(assert_invalid (module (func (result v128) (v128.bitselect (i32.const 0) (v128.const i32x4 0 0 0 0) (v128.const i32x4 0 0 0 0)))) "type mismatch")
(assert_invalid (module (func (result v128) (v128.bitselect (v128.const i32x4 0 0 0 0) (v128.const i32x4 0 0 0 0) (i32.const 0)))) "type mismatch")
(assert_invalid (module (func (result v128) (v128.bitselect (i32.const 0) (i32.const 0) (i32.const 0)))) "type mismatch")
;; andnot
(assert_invalid (module (func (result v128) (v128.andnot (i32.const 0) (v128.const i32x4 0 0 0 0)))) "type mismatch")
(assert_invalid (module (func (result v128) (v128.andnot (v128.const i32x4 0 0 0 0) (i32.const 0)))) "type mismatch")
(assert_invalid (module (func (result v128) (v128.andnot (i32.const 0) (i32.const 0)))) "type mismatch")

;; Combination

(module (memory 1)
  (func (export "v128.not-in-block")
    (block
      (drop
        (block (result v128)
          (v128.not
            (block (result v128) (v128.load (i32.const 0)))
          )
        )
      )
    )
  )
  (func (export "v128.and-in-block")
    (block
      (drop
        (block (result v128)
          (v128.and
            (block (result v128) (v128.load (i32.const 0)))
            (block (result v128) (v128.load (i32.const 1)))
          )
        )
      )
    )
  )
  (func (export "v128.or-in-block")
    (block
      (drop
        (block (result v128)
          (v128.or
            (block (result v128) (v128.load (i32.const 0)))
            (block (result v128) (v128.load (i32.const 1)))
          )
        )
      )
    )
  )
  (func (export "v128.xor-in-block")
    (block
      (drop
        (block (result v128)
          (v128.xor
            (block (result v128) (v128.load (i32.const 0)))
            (block (result v128) (v128.load (i32.const 1)))
          )
        )
      )
    )
  )
  (func (export "v128.bitselect-in-block")
    (block
      (drop
        (block (result v128)
          (v128.bitselect
            (block (result v128) (v128.load (i32.const 0)))
            (block (result v128) (v128.load (i32.const 1)))
            (block (result v128) (v128.load (i32.const 2)))
          )
        )
      )
    )
  )
  (func (export "v128.andnot-in-block")
    (block
      (drop
        (block (result v128)
          (v128.andnot
            (block (result v128) (v128.load (i32.const 0)))
            (block (result v128) (v128.load (i32.const 1)))
          )
        )
      )
    )
  )
  (func (export "nested-v128.not")
    (drop
      (v128.not
        (v128.not
          (v128.not
            (v128.load (i32.const 0))
          )
        )
      )
    )
  )
  (func (export "nested-v128.and")
    (drop
      (v128.and
        (v128.and
          (v128.and
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
          (v128.and
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
        )
        (v128.and
          (v128.and
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
          (v128.and
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
        )
      )
    )
  )
  (func (export "nested-v128.or")
    (drop
      (v128.or
        (v128.or
          (v128.or
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
          (v128.or
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
        )
        (v128.or
          (v128.or
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
          (v128.or
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
        )
      )
    )
  )
  (func (export "nested-v128.xor")
    (drop
      (v128.xor
        (v128.xor
          (v128.xor
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
          (v128.xor
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
        )
        (v128.xor
          (v128.xor
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
          (v128.xor
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
        )
      )
    )
  )
  (func (export "nested-v128.bitselect")
    (drop
      (v128.bitselect
        (v128.bitselect
          (v128.bitselect
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
            (v128.load (i32.const 2))
          )
          (v128.bitselect
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
            (v128.load (i32.const 2))
          )
          (v128.bitselect
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
            (v128.load (i32.const 2))
          )
        )
        (v128.bitselect
          (v128.bitselect
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
            (v128.load (i32.const 2))
          )
          (v128.bitselect
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
            (v128.load (i32.const 2))
          )
          (v128.bitselect
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
            (v128.load (i32.const 2))
          )
        )
        (v128.bitselect
          (v128.bitselect
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
            (v128.load (i32.const 2))
          )
          (v128.bitselect
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
            (v128.load (i32.const 2))
          )
          (v128.bitselect
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
            (v128.load (i32.const 2))
          )
        )
      )
    )
  )
  (func (export "nested-v128.andnot")
    (drop
      (v128.andnot
        (v128.andnot
          (v128.andnot
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
          (v128.andnot
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
        )
        (v128.andnot
          (v128.andnot
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
          (v128.andnot
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
        )
      )
    )
  )
  (func (export "as-param")
    (drop
      (v128.or
        (v128.and
          (v128.not
            (v128.load (i32.const 0))
          )
          (v128.not
            (v128.load (i32.const 1))
          )
        )
        (v128.xor
          (v128.bitselect
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
            (v128.load (i32.const 2))
          )
          (v128.andnot
            (v128.load (i32.const 0))
            (v128.load (i32.const 1))
          )
        )
      )
    )
  )
)
(assert_return (invoke "v128.not-in-block"))
(assert_return (invoke "v128.and-in-block"))
(assert_return (invoke "v128.or-in-block"))
(assert_return (invoke "v128.xor-in-block"))
(assert_return (invoke "v128.bitselect-in-block"))
(assert_return (invoke "v128.andnot-in-block"))
(assert_return (invoke "nested-v128.not"))
(assert_return (invoke "nested-v128.and"))
(assert_return (invoke "nested-v128.or"))
(assert_return (invoke "nested-v128.xor"))
(assert_return (invoke "nested-v128.bitselect"))
(assert_return (invoke "nested-v128.andnot"))
(assert_return (invoke "as-param"))
