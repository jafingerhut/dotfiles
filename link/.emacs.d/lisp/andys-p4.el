(require 'p4_16-mode)
(require 'p4_14-mode)

;; Both P4_14 and P4_16 programs typically use a file name suffix of
;; '.p4', so it is not easy for Emacs to automatically determine from
;; the file name alone which mode to use.

;; If you put one of the lines below as the first line of your P4
;; program (with the ';;' Emacs Lisp comment characters removed),
;; Emacs will use that to choose the mode:

;; /* -*- mode: P4_16 -*- */
;; /* -*- mode: P4_14 -*- */

;; For files that do not have a line like that in them, the following
;; Emacs Lisp code can do a reasonable job of picking the right mode
;; based upon the file name, for files in the repository
;; https://github.com/p4lang/p4c

(setq auto-mode-alist
      (append '(
		("p4_14.*\\.p4$" . p4_14-mode)
		("p4_16.*\\.p4$" . p4_16-mode)
		;; Use p4_14-mode on the next line if most of your .p4
		;; files use P4_14.
		("\\.p4$"      . p4_16-mode))
	      auto-mode-alist))

;; An old version of andys-p4.el below:
;;;; Treat P4 source code as C++ for purposes of editing
;;
;;(setq auto-mode-alist (cons '("\\.p4$" . c++-mode) auto-mode-alist))

(provide 'andys-p4)
