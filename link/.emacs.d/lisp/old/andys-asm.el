;; An excerpt from hilit19.el for asm-mode

;; (hilit-set-mode-patterns
;;  'asm-mode
;;  '(("/\\*" "\\*/" comment)
;;    ("^#[ \t]*\\(undef\\|define\\).*$" "[^\\]$" define)
;;    ("^#.*$" nil include)
;;    ;; labels
;;    ("^.+:" nil defun)
;;    ;; assembler directives
;;    ("^[ \t]*\\..*$" nil decl)
;;    ;; register names
;;    ("\\$[a-z0-9]+" nil string)
;;    ;; mnemonics
;;    ("^[ \t]*[a-z]+" nil struct)))

;; Andy's modified version

(cond
 (hilit-enabled
  (hilit-set-mode-patterns
   'asm-mode
   '(("/\\*" "\\*/" comment)
     ;; Metro ucode developers often use C++-style '//' for comments
     ("//" "$" comment)
     ("^#[ \t]*\\(undef\\|define\\).*$" "[^\\]$" define)
     ("^#.*$" nil include)
     ;; labels
     ("^[ \t]*[a-zA-Z0-9_\\]+:" nil defun)
     ;; Macros created by Metro ucode developers for defining function labels
     ("^[ \t]*FUNCT[ \t].+$" nil defun)
     ("^[ \t]*GLOBAL_FUNCT[ \t].+$" nil defun)
     ("^[ \t]*GI_FUNCT[ \t].+$" nil defun)
     ("^[ \t]*GLOBAL_GI_FUNCT[ \t].+$" nil defun)
     ;; assembler directives
     ("^[ \t]*\\..*$" nil decl)
     ;; register names
     ("\\$[a-z0-9]+" nil string)
     ("a[0-9]+" nil string)
     ;; mnemonics
     ("^[ \t]*[a-z0-9_.]+" nil struct)))))

(provide 'andys-asm)
