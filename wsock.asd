#|
  This file is a part of wsock project.
  Copyright (c) 2015 Eitaro Fukamachi (e.arrows@gmail.com)
|#

#|
  Author: Eitaro Fukamachi (e.arrows@gmail.com)
|#

(in-package :cl-user)
(defpackage wsock-asd
  (:use :cl :asdf))
(in-package :wsock-asd)

#+quicklisp (ql:quickload :cffi-grovel)
#-quicklisp (asdf:load-system :cffi-grovel)

(defsystem wsock
  :version "0.1"
  :author "Eitaro Fukamachi"
  :license "MIT"
  :depends-on (:cffi)
  :components ((:module "src"
                :components
                ((:file "wsock")
                 (:module "wsock-components"
                  :pathname "wsock"
                  :depends-on ("wsock" "syscall-components")
                  :components
                  ((cffi-grovel:grovel-file "grovel")
                   (:file "cffi" :depends-on ("grovel"))))
                 (:file "syscall")
                 (:module "syscall-components"
                  :pathname "syscall"
                  :depends-on ("syscall")
                  :components
                  ((:file "cffi" :depends-on ("grovel"))
                   (cffi-grovel:grovel-file "grovel"))))))
  :description "Low-level UNIX socket library"
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
  :in-order-to ((test-op (test-op wsock-test))))
