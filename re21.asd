#|
  This file is a part of re21 project.
  Copyright (c) 2016 Eitaro Fukamachi (e.arrows@gmail.com)
|#

#|
  Author: Eitaro Fukamachi (e.arrows@gmail.com)
|#

(in-package :cl-user)
(defpackage re21-asd
  (:use :cl :asdf))
(in-package :re21-asd)

(defsystem re21
  :version "0.1"
  :author "Eitaro Fukamachi"
  :license "Public Domain"
  :depends-on (:cl-ppcre
               :split-sequence
               :cl-syntax)
  :components ((:module "src"
                :components
                ((:file "re21"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op re21-test))))
