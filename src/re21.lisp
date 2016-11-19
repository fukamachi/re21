(in-package :cl-user)
(defpackage re21
  (:use #:cl)
  (:import-from #:cl-ppcre
                #:create-scanner
                #:scan-to-strings
                #:regex-replace
                #:regex-replace-all
                #:split)
  (:import-from #:split-sequence
                #:split-sequence)
  (:import-from #:cl-syntax
                #:define-package-syntax)
  (:export #:re-match
           #:re-groups
           #:re-replace
           #:re-split))
(in-package :re21)

(defun re-match (re string &rest keys &key start end)
  (declare (ignore start end))
  (etypecase re
    (function (apply re string keys))
    (string (apply #'ppcre:scan-to-strings re string keys))))

(defun re-groups (re string &rest keys &key start end)
  (declare (ignore start end))
  (let ((res (nth-value 1 (apply #'re-match re string keys))))
    (values (coerce res 'list)
            (not (null res)))))

(defun re-replace (re string replacement &rest keys &key start end global)
  (declare (ignore start end))
  (etypecase re
    (function
     (multiple-value-bind (scanner modifiers) (funcall re)
       (if (or (find #\G modifiers) global)
           (apply #'ppcre:regex-replace-all scanner string replacement keys)
           (apply #'ppcre:regex-replace scanner string replacement keys))))
    (string (apply (if global
                       #'ppcre:regex-replace-all
                       #'ppcre:regex-replace)
                   re string replacement keys))))

(defun re-split (re target-string &rest keys &key (start 0) end limit)
  (etypecase re
    (function
     (apply #'ppcre:split (funcall re) target-string keys))
    (string
     (apply #'ppcre:split re target-string keys))
    (standard-char
     (split-sequence re target-string
                     :start start :end end :count limit))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun segment-reader (stream ch n)
    (if (> n 0)
        (let ((chars))
          (do ((curr (read-char stream)
                     (read-char stream)))
              ((char= ch curr))
            (push curr chars))
          (cons (coerce (nreverse chars) 'string)
                (segment-reader stream ch (- n 1))))))

  (defun modifier-reader (stream)
    (let ((char (read-char stream nil)))
      (unread-char char stream)
      (when (alpha-char-p char)
        (read-preserving-whitespace stream))))

  (defun regex-with-modifier (regex modifier)
    (format nil "~@[(?~(~A~))~]~A" modifier regex))

  (defun regexp-reader (stream sub-char numarg)
    (declare (ignore numarg))
    (let* ((segment (segment-reader stream sub-char 1))
           (modifiers (modifier-reader stream)))
      `(lambda (&optional str &rest keys)
         (if str
             (apply #'ppcre:scan-to-strings
                    ,(regex-with-modifier (car segment) modifiers)
                    str
                    keys)
             (values (ppcre:create-scanner
                      ,(regex-with-modifier (car segment)
                                            (and modifiers
                                                 (remove #\G (symbol-name modifiers)))))
                     ,(and modifiers (coerce (symbol-name modifiers) 'simple-vector))))))))

(syntax:define-package-syntax :re21
  (:merge :standard)
  (:dispatch-macro-char #\# #\/ #'regexp-reader))
