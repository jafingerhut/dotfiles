;; Treat P4 source code as C++ for purposes of editing

(setq auto-mode-alist (cons '("\\.p4$" . c++-mode) auto-mode-alist))

(provide 'andys-p4)
