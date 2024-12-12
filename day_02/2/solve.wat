;;-*- indent-tabs-mode:nil;tab-width:2;coding:utf-8 -*-
(module
  (import "js" "mem" (memory 1))

  (func $solve (param $addr i32) (result i32)
    (local $char  i32)
    (local $game  i32)
    (local $temp  i32)
    (local $red   i32)
    (local $green i32)
    (local $blue  i32)
    (local $acc   i32)
    (loop  $GAME
    (block $GAME_END
      (br_if $GAME_END  (i32.eqz (i32.load8_u (local.get $addr))))
      (local.tee $addr  (i32.add (local.get $addr) (i32.const 5)))
      (local.set $char  (i32.load8_u))
      (local.set $red   (i32.const 0))
      (local.set $green (i32.const 0))
      (local.set $blue  (i32.const 0))
      (local.set $game  (i32.const 0))
      (loop ;; Parse game number
        (i32.sub (local.get $char) (i32.const 0x30))
        (i32.mul (local.get $game) (i32.const 0x0A))
        (local.set $game (i32.add))
        (local.tee $addr (i32.add (local.get $addr) (i32.const 1)))
        (local.tee $char (i32.load8_u))
        (br_if     0     (i32.xor (i32.const 0x3A)))) ;; Until ':'
      (loop $READ_COLOR
        (local.tee $addr (i32.add (local.get $addr) (i32.const 2))) ;; Skip space
        (local.set $char (i32.load8_u))
        (local.set $temp (i32.const 0))
        (loop
          (i32.sub (local.get $char) (i32.const 0x30))
          (i32.mul (local.get $temp) (i32.const 0x0A))
          (local.set $temp (i32.add))
          (local.tee $addr (i32.add (local.get $addr) (i32.const 1)))
          (local.tee $char (i32.load8_u))
          (br_if     0     (i32.xor (i32.const 0x20)))) ;; Read until ' '
        (block $SET_COLOR
          (local.tee $addr (i32.add (local.get $addr) (i32.const 1)))
          (local.set $char (i32.load8_u))
          (block
            (br_if 0 (i32.xor (local.get $char) (i32.const 0x72))) ;; Set red
            (block
              (br_if     0    (i32.lt_u (local.get $temp) (local.get $red)))
              (local.set $red (local.get $temp)))
            (br $SET_COLOR))
          (block
            (br_if 0 (i32.xor (local.get $char) (i32.const 0x67))) ;; Set green
            (block
              (br_if     0      (i32.lt_u (local.get $temp) (local.get $green)))
              (local.set $green (local.get $temp)))
            (br $SET_COLOR))
          (block
            (br_if 0 (i32.xor (local.get $char) (i32.const 0x62))) ;; Set blue
            (block
              (br_if     0     (i32.lt_u (local.get $temp) (local.get $blue)))
              (local.set $blue (local.get $temp)))
            (br $SET_COLOR)))
      (loop $NEXT_ACTION
        (local.tee $addr       (i32.add (local.get $addr) (i32.const 1)))
        (local.set $char       (i32.load8_u))
        (br_if     $READ_COLOR (i32.eq (local.get $char) (i32.const 0x2C)))
        (br_if     $READ_COLOR (i32.eq (local.get $char) (i32.const 0x3B)))
        (block
          (br_if    0                (i32.xor (local.get $char) (i32.const 0x0A)))
          (i32.mul (local.get $blue) (i32.mul (local.get $red) (local.get $green)))
          (local.set $acc  (i32.add (local.get $acc)))
          (local.set $addr (i32.add (local.get $addr) (i32.const 1)))
          (br        $GAME))
        (br $NEXT_ACTION)))))
    (local.get $acc))

  (export "solve" (func $solve))
)
