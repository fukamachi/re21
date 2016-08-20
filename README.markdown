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

(re-groups "(\\w+)\\s+(\\w+)\\s+(\\d{1,2})\\.(\\d{1,2})\\.(\\d{4})"
           "Frank Zappa 21.12.1940")
;=> ("Frank" "Zappa" "21" "12" "1940")

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
;=> "Eitαro Fukαmαchi"
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

## Credits

* Eitaro Fukamachi (e.arrows@gmail.com)

## License

RE21 is free and unencumbered software released into the public domain.
