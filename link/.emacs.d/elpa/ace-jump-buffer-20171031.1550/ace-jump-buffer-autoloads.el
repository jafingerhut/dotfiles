;;; ace-jump-buffer-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "ace-jump-buffer" "../../../../../.emacs.d/elpa/ace-jump-buffer-20171031.1550/ace-jump-buffer.el"
;;;;;;  "988286c8860463c3b82e39fe525f2852")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/ace-jump-buffer-20171031.1550/ace-jump-buffer.el

(autoload 'ace-jump-buffer "ace-jump-buffer" "\
Quickly hop to buffer with `avy'.

\(fn)" t nil)

(autoload 'ace-jump-buffer-other-window "ace-jump-buffer" "\
Quickly hop to buffer with `avy' in other window.

\(fn)" t nil)

(autoload 'ace-jump-buffer-in-one-window "ace-jump-buffer" "\
Quickly hop to buffer with `avy' in one window.

\(fn)" t nil)

(autoload 'ace-jump-buffer-with-configuration "ace-jump-buffer" "\
Quickly hop to buffer with `avy' with selected configuration.

\(fn)" t nil)

(autoload 'make-ace-jump-buffer-function "ace-jump-buffer" "\
Create a `bs-configuration' and interactive defun using `NAME'.

It will displays buffers that don't get rejected by the body of
`BUFFER-LIST-REJECT-FILTER'.

\(fn NAME &rest BUFFER-LIST-REJECT-FILTER)" nil t)

(function-put 'make-ace-jump-buffer-function 'lisp-indent-function '1)

;;;### (autoloads "actual autoloads are elsewhere" "ace-jump-buffer"
;;;;;;  "../../../../../.emacs.d/elpa/ace-jump-buffer-20171031.1550/ace-jump-buffer.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/ace-jump-buffer-20171031.1550/ace-jump-buffer.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ace-jump-buffer" '("ajb" "bs--sort-by-recentf")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/ace-jump-buffer-20171031.1550/ace-jump-buffer-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/ace-jump-buffer-20171031.1550/ace-jump-buffer.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ace-jump-buffer-autoloads.el ends here
