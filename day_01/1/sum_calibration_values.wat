;;-*- indent-tabs-mode:nil;tab-width:2;coding:utf-8 -*-
(module
  (import "js" "mem" (memory 1))

  (func $solve (param $addr i32) (result i32)
    (local $has_fnum i32)
    (local $fnum     i32)
    (local $lnum     i32)
    (local $ch       i32)
    (local $acc      i32)
    (local.set $acc (i32.const 0))
    (loop  $NEW_LINE
      (local.set $has_fnum (i32.const 0x00))
      (local.set $fnum     (i32.const 0x30))
      (local.set $lnum     (i32.const 0x30))
      (loop  $NEW_CHAR
        (local.set $ch   (i32.load8_u (local.get $addr)))
        (local.set $addr (i32.add     (local.get $addr) (i32.const 1)))
        (block $DIGIT
          (br_if 0 (i32.gt_u (local.get $ch) (i32.const 0x39)))
          (br_if 0 (i32.lt_u (local.get $ch) (i32.const 0x30)))
          (block $SKIP_FIRST
            (br_if $SKIP_FIRST   (local.get $has_fnum))
            (local.set $fnum     (local.get $ch))
            (local.set $has_fnum (i32.const 0x01)))
          (local.set $lnum (local.get $ch))
          (br $NEW_CHAR))
        (block $ENTER
          (br_if 0 (i32.xor (local.get $ch) (i32.const 0x0A)))
          (i32.sub (local.get $lnum) (i32.const 0x30))
          (i32.sub (local.get $fnum) (i32.const 0x30))
          (i32.add (i32.mul          (i32.const 0x0A)))
          (local.set $acc (i32.add (local.get $acc)))
          (br $NEW_LINE))
       (br_if $NEW_CHAR (local.get $ch))))
    (local.get $acc))

  (export "solve" (func $solve))
)
