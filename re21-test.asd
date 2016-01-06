#|
  This file is a part of re21 project.
  Copyright (c) 2016 Eitaro Fukamachi (e.arrows@gmail.com)
|#

(in-package :cl-user)
(defpackage re21-test-asd
  (:use :cl :asdf))
(in-package :re21-test-asd)

(defsystem re21-test
  :author "Eitaro Fukamachi"
  :license "Public Domain"
  :depends-on (:re21
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "re21"))))
  :description "Test system for re21"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
