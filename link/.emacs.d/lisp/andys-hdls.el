;; Load verilog mode only when needed
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
;; Any files that end in .v should be in verilog mode
(setq auto-mode-alist (cons  '("\\.v\\'" . verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons  '("\\.vh\\'" . verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons  '("\\.g\\'" . verilog-mode) auto-mode-alist))
;; Any files in verilog mode should have their keywords colorized
(add-hook 'verilog-mode-hook '(lambda () (font-lock-mode 1)))

;(setq auto-mode-alist (cons '("\\.vhd$"  . vhdl-mode) auto-mode-alist))
;(setq auto-mode-alist (cons '("\\.vhdl$" . vhdl-mode) auto-mode-alist))

(provide 'andys-hdls)
