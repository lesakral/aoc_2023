;;-*- indent-tabs-mode:nil;tab-width:2;coding:utf-8 -*-
(module
  (import "js" "mem" (memory 1))

  (func $solve (param $addr i32) (result i32)
    (local $acc   i32)
    (local $fnum? i32)   
    (local $fnum  i32)
    (local $lnum  i32)
    (local $char  i32)
    (local.set $acc   (i32.const 0x00))
    (local.set $fnum? (i32.const 0x00))
    (local.set $fnum  (i32.const 0x30))
    (local.set $lnum  (i32.const 0x30))
    (loop $GETCHAR
      (block $GETCHAR_ADV
        (local.set $char (i32.load8_u (local.get $addr)))
        (block $NUMBER
          (block $NUMBER_OK
            (block ;; 0-9 characters
              (br_if 0 (i32.gt_u (local.get $char) (i32.const 0x39)))
              (br_if 0 (i32.lt_u (local.get $char) (i32.const 0x30)))
              (br    $NUMBER_OK))
            (block ;; "one" string
              (br_if 0 (i32.xor (local.get $char)                                       (i32.const 0x6F)))
              (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 1))) (i32.const 0x6E)))
              (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 2))) (i32.const 0x65)))
              (local.set $char (i32.const 0x31))
              (br $NUMBER_OK))
            (block ;; "two" or "three strings
              (br_if 0 (i32.xor (local.get $char) (i32.const 0x74)))
              (block
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 1))) (i32.const 0x77)))
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 2))) (i32.const 0x6F)))
                (local.set $char (i32.const 0x32))
                (br $NUMBER_OK))
              (block
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 1))) (i32.const 0x68)))
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 2))) (i32.const 0x72)))
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 3))) (i32.const 0x65)))
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 4))) (i32.const 0x65)))
                (local.set $char (i32.const 0x33))
                (br $NUMBER_OK)))
            (block ;; "four" or "five" strings
              (br_if 0 (i32.xor (local.get $char) (i32.const 0x66)))
              (block
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 1))) (i32.const 0x6F)))
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 2))) (i32.const 0x75)))
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 3))) (i32.const 0x72)))
                (local.set $char (i32.const 0x34))
                (br $NUMBER_OK))
              (block
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 1))) (i32.const 0x69)))
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 2))) (i32.const 0x76)))
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 3))) (i32.const 0x65)))
                (local.set $char (i32.const 0x35))
                (br $NUMBER_OK)))
            (block ;; "six" or "seven" strings
              (br_if 0 (i32.xor (local.get $char) (i32.const 0x73)))
              (block
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 1))) (i32.const 0x69)))
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 2))) (i32.const 0x78)))
                (local.set $char (i32.const 0x36))
                (br $NUMBER_OK))
              (block
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 1))) (i32.const 0x65)))
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 2))) (i32.const 0x76)))
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 3))) (i32.const 0x65)))
                (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 4))) (i32.const 0x6E)))
                (local.set $char (i32.const 0x37))
                (br $NUMBER_OK)))
            (block ;; "eight" string
              (br_if 0 (i32.xor (local.get $char)                                       (i32.const 0x65)))
              (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 1))) (i32.const 0x69)))
              (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 2))) (i32.const 0x67)))
              (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 3))) (i32.const 0x68)))
              (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 4))) (i32.const 0x74)))
              (local.set $char (i32.const 0x38))
              (br $NUMBER_OK))
            (block ;; "nine" string
              (br_if 0 (i32.xor (local.get $char)                                       (i32.const 0x6E)))
              (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 1))) (i32.const 0x69)))
              (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 2))) (i32.const 0x6E)))
              (br_if 0 (i32.xor (i32.load8_u (i32.add (local.get $addr) (i32.const 3))) (i32.const 0x65)))
              (local.set $char (i32.const 0x39))
              (br $NUMBER_OK))
            (br $NUMBER))
            (block ;; Set number(s)
              (br_if 0 (local.get $fnum?))
              (local.set $fnum  (local.get $char))
              (local.set $fnum? (i32.const 0x01)))
            (local.set $lnum (local.get $char))
            (br $GETCHAR_ADV))
        (block $ENTER
          (br_if 0 (i32.xor (local.get $char) (i32.const 0x0A)))
          (i32.sub (local.get $lnum) (i32.const 0x30))
          (i32.sub (local.get $fnum) (i32.const 0x30))
          (i32.add (i32.mul          (i32.const 0x0A)))
          (local.set $acc   (i32.add (local.get $acc)))
          (local.set $fnum? (i32.const 0x00))
          (local.set $fnum  (i32.const 0x30))
          (local.set $lnum  (i32.const 0x30))
          (br $GETCHAR_ADV)))
      (local.set $addr (i32.add (local.get $addr) (i32.const 0x01)))
      (br_if $GETCHAR (local.get $char)))
    (local.get $acc))

  (export "solve" (func $solve))
)
