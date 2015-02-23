#|
  This file is a part of wsock project.
  Copyright (c) 2015 Eitaro Fukamachi (e.arrows@gmail.com)
|#

(in-package :cl-user)
(defpackage wsock-test-asd
  (:use :cl :asdf))
(in-package :wsock-test-asd)

(defsystem wsock-test
  :author "Eitaro Fukamachi"
  :license "MIT"
  :depends-on (:wsock
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "wsock"))))

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
