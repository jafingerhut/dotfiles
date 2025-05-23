(require 'verilog-mode)

;; verilog-mode.el, at least the version in Emacs 26.1 that I read,
;; contains the following two lines.  I believe the effect of these is
;; that _every time_ that compilation-mode is started on a buffer
;; later, it executes all functions in the list compilation-mode-hook.
;; verilog-error-regexp-add-emacs adds new elements to the variables
;; compilation-error-regexp-alist and
;; compilation-error-regexp-alist-alist.  I _do not_ want those
;; modifications to be made, because they cause text strings in the
;; output of John Bettink's 'makesim' command to be recognized as
;; filenames, that I do not want to be recognized as filenames.

;;(if (featurep 'xemacs) (add-hook 'compilation-mode-hook 'verilog-error-regexp-add-xemacs))
;;(if (featurep 'emacs) (add-hook 'compilation-mode-hook 'verilog-error-regexp-add-emacs))

;; So, after require'ing verilog-mode, remove these functions from
;; compilation-mode-hook, if they are present.

(remove-hook 'compilation-mode-hook 'verilog-error-regexp-add-xemacs)
(remove-hook 'compilation-mode-hook 'verilog-error-regexp-add-emacs)

(setq auto-mode-alist
      (append '(
		("\\.npl$"      . verilog-mode))
	      auto-mode-alist))

(provide 'andys-npl)
