;; I want to have // style comments in C code highlighted, and
;; inserted with comment-region.  I'm guessing that the easiest way to
;; do this is just to use Emacs C++ mode for C files.  Hopefully there
;; won't be any negative effects from this, but I can always go back
;; to C mode and make more custom changes to it if so.

(setq auto-mode-alist (cons '("\\.c$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.C$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.lex$" . c++-mode) auto-mode-alist))

;;; Synopsys scripts have the same comment and string syntax as C, so
;;; the highlighting is useful.  Some have a ".scr" suffix, other
;;; ".setup".

(setq auto-mode-alist (cons '("\\.syn$" . c-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.scr$" . c-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.con$" . c-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.dcsh$" . c-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.setup$" . c-mode) auto-mode-alist))


;; c-basic-offset controls the normal C/C++ indentation level.  Make
;; it 4 spaces instead of default 2.  You have to do it in this way
;; (i.e. using add-hook) because of the strange way the cc-mode
;; initializes the value of `c-basic-offset'.

;; Also configure indent-tabs-mode variable so that indentation uses
;; ASCII space characters for all indentation, instead of the default
;; mix of ASCII tab and space characters.

(add-hook 'c++-mode-hook
	  (lambda ()
	    (setq c-basic-offset 4)
	    (setq indent-tabs-mode nil)
	    (cpp-highlight-buffer t)))
(add-hook 'c-mode-hook
	  (lambda ()
	    (setq c-basic-offset 4)
	    (setq indent-tabs-mode nil)
	    (cpp-highlight-buffer t)))
(add-hook 'java-mode-hook
	  (lambda ()
	    (setq c-basic-offset 4)))


;; Only indent the C code line when the point is at the beginning of
;; the line, or within the indentation.  Later in the line, insert a
;; TAB character.
(setq c-tab-always-indent nil)


;; With the default definition of c-offsets-alist, emacs C/C++ mode
;; defaults to auto-indenting code like this:

;;     if (x == y)
;;         {
;;             foo();
;;         }

;; With the following definition of c-offsets-alist

;; '(c-offsets-alist (quote ((substatement-open . 0))))

;; it auto-indents like this:

;;     if (x == y)
;;     {
;;         foo();
;;     }

(provide 'andys-c)
