# RE21

RE21 is CL21's spin-off project that provides neat APIs for regular expressions.

## Usage

```common-lisp
(use-package :re21)

(re-match "^Hello, (.+?)!$" "Hello, World!")
;=> "Hello, World!"
;   #("World")

(re-match "^(\\d{4})-(\\d{2})-(\\d{2})$" "2016-01-06")
;=> "2016-01-06"
;   #("2016" "01" "06")

(re-split "-" "2016-01-06")
;=> ("2016" "01" "06")

(re-replace "a" "Eitaro Fukamachi" "α" :global t)
;=> "Eitαrow Fukαmαchi"
;   T

;; Enable the syntax for regular expressions
(syntax:use-syntax :re21)

(#/^Hello, (.+?)!$/ "Hello, World!")
;=> "Hello, World!"
;   #("World")

(#/^(\d{4})-(\d{2})-(\d{2})$/ "2014-01-23")
;=> "2014-01-23"
;   #("2014" "01" "23")

(re-replace #/a/g "Eitaro Fukamachi" "α")
;=> "Eitαrow Fukαmαchi"
;   T
```

## Installation

```
cd ~/common-lisp
git clone https://github.com/fukamachi/re21
```

```common-lisp
(ql:quickload :re21)
```

## Author

* Eitaro Fukamachi (e.arrows@gmail.com)

## Copyright

Copyright (c) 2016 Eitaro Fukamachi (e.arrows@gmail.com)

## License

Licensed under the Public Domain License.