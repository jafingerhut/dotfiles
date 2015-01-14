;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lua mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'lua-mode)

(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))

;; Celestia uses Lua as a scripting language, and its scripts have a
;; different suffix.

(setq auto-mode-alist (cons '("\\.celx$" . lua-mode) auto-mode-alist))

(provide 'andys-lua)
