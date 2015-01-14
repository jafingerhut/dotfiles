;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Scheme indentation customizations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(put 'while 'scheme-indent-function 'defun)
(put 'define 'scheme-indent-function 'defun)
(put 'if 'scheme-indent-function 'defun)

(provide 'andys-scheme)
