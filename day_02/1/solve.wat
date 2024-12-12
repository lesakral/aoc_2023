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
      (br_if     $GAME_END (i32.eqz (i32.load8_u (local.get $addr))))
      (local.tee $addr     (i32.add (local.get $addr) (i32.const 5)))
      (local.set $char     (i32.load8_u))
      (local.set $game     (i32.const 0x00))
      (loop ;; Parse game number
        (i32.sub (local.get $char) (i32.const 0x30))
        (i32.mul (local.get $game) (i32.const 0x0A))
        (local.set $game (i32.add))
        (local.tee $addr (i32.add (local.get $addr) (i32.const 1)))
        (local.tee $char (i32.load8_u))
        (br_if     0     (i32.xor (i32.const 0x3A)))) ;; Read until ':'
      (loop $HINT
        (local.set $red   (i32.const 0))
        (local.set $green (i32.const 0))
        (local.set $blue  (i32.const 0))
      (loop $COLOR
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
        (block
          (local.tee $addr (i32.add (local.get $addr) (i32.const 1)))
          (local.set $char (i32.load8_u))
          (block
            (br_if     0    (i32.xor (local.get $char) (i32.const 0x72)))
            (local.set $red (local.get $temp))
            (br        1))
          (block
            (br_if     0      (i32.xor (local.get $char) (i32.const 0x67)))
            (local.set $green (local.get $temp))
            (br        1))
          (local.set $blue (local.get $temp)))
      (loop
        (local.tee $addr (i32.add (local.get $addr) (i32.const 1)))
        (local.set $char (i32.load8_u))
        (br_if $COLOR (i32.eq  (local.get $char) (i32.const 0x2C)))
        (block
          (br_if 0 (i32.xor (local.get $char) (i32.const 0x3B)))
          (block
            (br_if 0     (i32.gt_u (local.get $red)   (i32.const 12)))
            (br_if 0     (i32.gt_u (local.get $green) (i32.const 13)))
            (br_if $HINT (i32.le_u (local.get $blue)  (i32.const 14))))
          (loop
            (local.set $char (i32.load8_u (local.get $addr)))
            (local.set $addr (i32.add     (local.get $addr) (i32.const 0x01)))
            (br_if     $GAME (i32.eq      (local.get $char) (i32.const 0x0A)))
            (br        0)))
        (block ;; Support '\n'
          (br_if 0 (i32.xor (local.get $char) (i32.const 0x0A)))
          (block ;; Check if possible
            (br_if     0    (i32.gt_u (local.get $red)   (i32.const 12)))
            (br_if     0    (i32.gt_u (local.get $green) (i32.const 13)))
            (br_if     0    (i32.gt_u (local.get $blue)  (i32.const 14)))
            (local.set $acc (i32.add  (local.get $acc)   (local.get $game))))
          (local.set $addr (i32.add (local.get $addr) (i32.const 1)))
          (br        $GAME))
        (br 0))))))
    (local.get $acc))

  (export "solve" (func $solve))
)
