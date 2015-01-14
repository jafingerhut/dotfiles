;; Config needed for Emacs 24 ELPA
(require 'package)
(add-to-list 'package-archives '("marmalade" .
				 "http://marmalade-repo.org/packages/"))
(package-initialize)
;; To add clojure-mode, do M-x package-list-packages, find
;; clojure-mode in the resulting buffer containing a list of packages,
;; go to its line, press 'i' to mark it for installation, then 'x' to
;; execute that installation.  A new buffer should appear, and it is
;; normal for it to have compile warnings.  As long as there are no
;; errors, you should be fine.


(mwheel-install)

(setq inhibit-startup-message t)
(setq ls-lisp-dirs-first t)

;; I usually like white space to be ignored when running ediff on two
;; files, since those two files are usually source code in which most
;; white space is indentation.
(defvar ediff-diff-options "-w")

;; When programming, it is most useful for dynamic abbreviations to
;; match the case of the identifier found elsewhere in the file.
(setq dabbrev-case-replace nil)

;; I don't care if it is slow to display line numbers in large files.
;; It is sometimes extremely handy to have the line number displayed
;; when ediff-ing two large buffers.
(setq line-number-display-limit 16000000)

(setq dired-listing-switches "-agl")

(setq-default ispell-program-name "aspell")
;(setq-default ispell-extra-args '("--reverse"))


(defun insert-verilog-assertion ()
  (interactive)
  (insert "// synopsys translate_off\n")
  (insert "// verilint translate off\n")
  (insert "always @(posedge CLK)\n")
  (insert "begin\n")
  (insert "  if (go) begin\n")
  (insert "    $display(\"ERROR %0t: %m - .  Design bug.\", $time);\n")
  (insert "  end\n")
  (insert "end\n")
  (insert "// verilint translate on\n")
  (insert "// synopsys translate_on\n")
  )

(defun revert-buffer-no-confirm ()
  (interactive)
  (revert-buffer t t))


(fset 'find-next-tag-viper
   "1\M-.")
(fset 'find-next-tag-non-viper
   "\C-u\M-.")


;; Note that function etags-tags-table-files in etags.el creates a
;; list of all file names in a tags table.

;; This is called through a couple of levels of indirection from
;; function next-file in that same file, as excerpted below.

;	 (save-excursion
;	   ;; Visit the tags table buffer to get its list of files.
;	   (visit-tags-table-buffer)
;	   ;; Copy the list so we can setcdr below, and expand the file
;	   ;; names while we are at it, in this buffer's default directory.
;	   (setq next-file-list (mapcar 'expand-file-name (tags-table-files)))

(defun assign-tags-table-files-to-variable ()
  (interactive)
  (save-excursion
    ;; Visit the tags table buffer to get its list of files.
    (visit-tags-table-buffer)
    ;; Copy the list so we can setcdr below, and expand the file
    ;; names while we are at it, in this buffer's default directory.
    (setq andys-tags-table-files (mapcar 'expand-file-name (tags-table-files)))))

;(defun grep-in-etags-files (command)
;  (let ((command-line (concat "")
;	(error-message "No more grep hits")
;	(name-of-mode "grep-etags"))
;    (compile-internal command-line
;		      error-message
;		      name-of-mode)))

;;
;; Bcole hook to gid
;;
(setq emacs-19-or-later-p (>= emacs-major-version 19))

(defun gid (command)
  "Run gid, with user-specified args, and collect output in a buffer.
 While gid runs asynchronously, you can use the \\[next-error] command
 to find the text that gid hits refer to.  Gid is Greg Mcgary's
 pre-digested-grep program, like ctags, but for grep."
  (interactive (list (read-input "Run gid (with args): "
                                 (symbol-around-point))))
  (require 'compile)
  (if emacs-19-or-later-p
      (compile-internal (concat "gid " command)
                        "No more gid hits" "gid" nil grep-regexp-alist)
    (compile1 (concat "gid " command)
              "No more gid hits" "gid" nil)))

(defun gid32 (command)
  "Run gid32, with user-specified args, and collect output in a buffer.
 While gid32 runs asynchronously, you can use the \\[next-error] command
 to find the text that gid32 hits refer to.  Gid32 is Greg Mcgary's
 pre-digested-grep program, like ctags, but for grep."
  (interactive (list (read-input "Run gid32 (with args): "
                                 (symbol-around-point))))
  (require 'compile)
  (if emacs-19-or-later-p
      (compile-internal (concat "gid32 " command)
                        "No more gid32 hits" "gid32" nil grep-regexp-alist)
    (compile1 (concat "gid32 " command)
              "No more gid hits" "gid" nil)))

(defun symbol-around-point ()
  "Return the symbol around the point as a string."
  (save-excursion
    (if (not (looking-at "\\s_\\|\\sw")) ; if not in a symbol
        (re-search-backward "\\s_\\|\\sw" nil t)) ; go into prev. one
    (buffer-substring
     (progn (forward-sexp 1) (point))
     (progn (backward-sexp 1) (point)))))

(defun downcase-symbol-around-point ()
  (interactive)
  "Downcase the symbol around the point."
  (save-excursion
    (if (not (looking-at "\\s_\\|\\sw")) ; if not in a symbol
        (re-search-backward "\\s_\\|\\sw" nil t)) ; go into prev. one
    (downcase-region
     (progn (forward-sexp 1) (point))
     (progn (backward-sexp 1) (point)))))

(defun list-buffers-then-other-window ()
  (interactive)
  (list-buffers)
  (other-window 1)
  )

;(global-set-key [f1]    'indent-region)
;(global-set-key [f1]    'save-buffer)
(global-set-key [f1] 'tags-search)
;(global-set-key [f2] 'tags-loop-continue)
(global-set-key [f2] 'cscope-find-global-definition)
(global-set-key [(shift f2)] 'cscope-find-this-symbol)
(global-set-key [(control f2)] 'cscope-find-functions-calling-this-function)
(global-set-key [(control shift f2)] 'cscope-find-called-functions)
;(global-set-key [(control f2)] 'gid)
;;(global-set-key [(control f2)] 'gid32)
;(global-set-key [f3]    'clipboard-kill-ring-save)
(global-set-key [(control f3)]    'ediff-buffers)
(global-set-key [(control shift f3)]    'cpp-re-highlight-buffer)
(global-set-key [f3]    'list-buffers-then-other-window)
;(global-set-key [f4]    'clipboard-yank)
;(global-set-key [f4]    'delete-matching-lines)
;(global-set-key [f4]    'common-lisp-hyperspec)
;(global-set-key [f5]    'compile)
(global-set-key [f6]    'other-window)
(global-set-key [(shift f6)]    'other-frame)
(global-set-key [(control f6)]    'compile)
(global-set-key [(control shift f6)]    'revert-buffer-no-confirm)
(global-set-key [f7]    'save-buffer)
(global-set-key [f8]    'anything)
(global-set-key [(shift f8)]    'occur)
(global-set-key [f9]    'previous-error)
(global-set-key [f10]   'next-error)
(global-set-key [f11]   'find-next-tag-viper)
;(global-set-key [f7]    'find-next-tag-non-viper)
(global-set-key [f12]   'find-tag-other-window)
;(global-set-key [f12]   'insert-verilog-assertion)

(global-set-key [(control shift f1)]   'andy-setup-first-shell-buffer)

(global-set-key [(control shift f4)]   'set-preferred-buffer-1)
(global-set-key [f4]   'goto-preferred-buffer-1)
(global-set-key [(control shift f5)]   'set-preferred-buffer-2)
(global-set-key [f5]   'goto-preferred-buffer-2)

(global-set-key [(control f4)]    'common-lisp-hyperspec)
(global-set-key [(control f7)]   'slime-compile-and-load-file)
(global-set-key [(control f8)]   'slime-compile-defun)

(global-set-key [(control shift f9)]   'set-preferred-tags-file-1)
(global-set-key [(control f9)]   'use-preferred-tags-file-1)
(global-set-key [(control shift f10)]   'set-preferred-tags-file-2)
(global-set-key [(control f10)]   'use-preferred-tags-file-2)

;(global-set-key [(alt n)]      'comint-next-input)
;(global-set-key [(alt p)]      'comint-previous-input)

;; The following key bindings are reasonable on my numeric keypad, but
;; may be different on your keyboard.

(global-set-key [f27]   'beginning-of-buffer)
(global-set-key [f29]   'scroll-down)
(global-set-key [f33]   'end-of-buffer)
(global-set-key [f35]   'scroll-up)

(define-key Buffer-menu-mode-map "n" 'next-line)
(define-key Buffer-menu-mode-map "p" 'previous-line)

;(shell)

(setq enable-local-variables 'query)
(set 'inhibit-local-variables t)

;;(setq compilation-error-regexp-alist
;;      (cons
;;       ;; Verilint
;;       ;; (W180)  qm_rfp_bb_gse.v, line 289: Zero extension of extra bits: q1_head
;;       '("\\([(][A-Za-z]+[0-9]+[)]\\)\\([ ]+\\)\\([^ \n]*\\), line \\([0-9]+\\):" 3 4)
;;       compilation-error-regexp-alist))

(defun prepend-to-load-path ( my-path )
  (cond
   ((file-directory-p my-path)
    (setq load-path (cons (expand-file-name my-path) load-path)))))

(defun append-to-load-path ( my-path )
  (cond
   ((file-directory-p my-path)
    (setq load-path (append load-path (list (expand-file-name my-path)))))))


;(setq andy-home-dir (getenv "ANDY_HOME_DIR"))
(setq andy-home-dir "~")
;;(prepend-to-load-path "/project/gbn_hw/switch/lib/emacs")
;;(prepend-to-load-path (concat andy-home-dir "/lib/emacs"))

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


;; The following line is optional.  You could also copy the file and
;; do your own customizations.
(prepend-to-load-path (concat andy-home-dir "/elisp"))
(prepend-to-load-path "/usr/local/share/emacs/site-lisp")
;(load (concat andy-home-dir "/elisp/verilog-mode-customization.el"))
;(load-library "p4")
(prepend-to-load-path (concat andy-home-dir "/sw/cvs/http-emacs"))
;(require 'hyperspec)

(require 'xcscope)
(require 'setnu)

;; The conditions checked below make sure that the Emacs program
;; reading this file is not XEmacs, and it is at least version 19.
;; This was intended to make this same file usable for XEmacs and GNU
;; Emacs, but the code for XEmacs highlighting of VHDL has not been
;; included here.

(defvar font-lock-enabled nil)
(defvar hilit-enabled nil)

(cond
 ((and (not (string-match "XEmacs" emacs-version))
       (boundp 'emacs-major-version)
       (>= emacs-major-version 19))
  ;; Common frame parameters for every platform
  (setq default-frame-alist
	'((cursor-color . "red")
	  (cursor-type . box)
	  (mouse-color . "green")
	  (foreground-color . "white")
	  (background-color . "darkblue")))
  (setq font-lock-enabled t)
  (require 'paren)
;;    (load-library "vhdl-mode")

  ;; Common actions to perform for any of these window systems, but
  ;; not if we are in text mode.
  (cond ((or (eq window-system 'ns)
	     (eq window-system 'x)
	     (eq window-system 'w32))
	 ;; Turn off the graphical toolbar
	 (tool-bar-mode -1)))

  (cond
   ((eq window-system 'ns)  ;; NextStep, for Emacs.app
;    (set-background-color "DarkBlue")
;    (set-foreground-color "white")
;    (set-cursor-color "red")
;    (set-frame-size (selected-frame) 81 56)
    (setq mac-command-modifier 'meta)
    (setq default-frame-alist
	  (append default-frame-alist
		  '((top . 0) (left . -10)
		    (width . 80) (height . 60)
		    ;;(font . "-*-Courier-normal-r-*-*-15-97-*-*-c-*-*-ansi-")
		    (font . "-*-Courier-normal-r-*-*-15-50-*-*-c-*-*-ansi-")
		    )))
    )
   ((eq window-system 'x)
    (setq default-frame-alist
	  (append default-frame-alist
		  '((top . 0) (left . -75)
		    (width . 80) (height . 64)
		    (font . "9x15")
		    )))
    )
   ((eq window-system 'w32)
;    (setq default-frame-alist
;         '((top . 0) (left . 350)
;           (width . 80) (height . 53)
;           (cursor-color . "red")
;           (cursor-type . box)
;           (foreground-color . "white")
;           (background-color . "darkblue")
;           (font . "-*-Courier-normal-r-*-*-13-97-*-*-c-*-*-ansi-")))

;        1         2         3         4         5         6         7         8         9        10        11        12        13        14
;2345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

    (setq default-frame-alist
	  (append default-frame-alist
		  '((top . 0) (left . 5)
		    (width . 142) (height . 48)
		    (font . "-*-CourierNew-normal-r-*-*-12-97-*-*-c-*-*-ansi-")
		    )))
    (setq initial-frame-alist '((top . 0) (left . 5)))
    )
   )))

;;; Define mode hooks
(setq auto-mode-alist (cons '("\\.fh$" . fortran-mode) auto-mode-alist))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Haskell mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.[hg]s$"  . haskell-mode)
                ("\\.hi$"     . haskell-mode)
                ("\\.l[hg]s$" . literate-haskell-mode))))
(autoload 'haskell-mode "haskell-mode"
   "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
   "Major mode for editing literate Haskell scripts." t)
(add-hook 'haskell-mode-hook 'turn-on-haskell-font-lock)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-hugs)

(setq haskell-hugs-program-name "hugs-devel")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ruby mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'pabbrev)
(require 'ruby-mode)
(require 'ruby-electric)

(defun ruby-eval-buffer ()
  (interactive)
  "Evaluate the buffer with ruby."
  (shell-command-on-region (point-min) (point-max) "ruby"))

(defun my-ruby-mode-hook ()
  (inf-ruby-keys)
  (font-lock-mode t)
  (setq standard-indent 2)
  (pabbrev-mode t)
  (ruby-electric-mode t)
  (define-key ruby-mode-map "\C-c\C-a" 'ruby-eval-buffer))

(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)

(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))

(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
				     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lua mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'lua-mode)

(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))

;; Celestia uses Lua as a scripting language, and its scripts have a
;; different suffix.

(setq auto-mode-alist (cons '("\\.celx$" . lua-mode) auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Old Vera stuff from Rolf Mueller's GNI home directory

;;(prepend-to-load-path "/export/home/rolf/emacs/modes")
;;(autoload 'vera-mode "vera-mode" "Vera Mode" t)
;;(setq auto-mode-alist (cons '("\\.vr[hi]?\\'" . vera-mode)
;;                          auto-mode-alist))

;;; Make the default mode for .h and .lex files C++, rather than C.
;;; This is to make it easy to highlight C++ .h and .lex files
;;; correctly that Zubin likes to write.



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



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

;;; Remove ".log" from the list of ignored extensions, since I use it
;;; quite often as the extension for dc_shell output files.

(require 'cl)

(setq completion-ignored-extensions
      (remove* ".log" completion-ignored-extensions ':test 'equal))

(require 'anything)

;; line number mode
(line-number-mode t)
(column-number-mode t)

;; un-disable case conversion commands
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'eval-expression 'disabled nil)



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

;; Add color to a shell running in emacs ‘M-x shell’
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'shell-mode-hook
	  (lambda ()
	    (remove-hook 'comint-output-filter-functions
			 'comint-watch-for-password-prompt)
	    (remove-hook 'comint-output-filter-functions
			 'comint-postoutput-scroll-to-bottom)))

;;
;; Only indent the C code line when the point is at the beginning of
;; the line, or within the indentation.  Later in the line, insert a
;; TAB character.
;;
(setq c-tab-always-indent nil)

(when font-lock-enabled
  (global-font-lock-mode 1))



;; This is a useful command that searches for the next semicolon, and
;; inserts the string " after 2 ns" immediately before it.  It is
;; useful for inserting such delays in VHDL signal assignment
;; statements.

(defun append-after-delay ()
  (interactive)
  (search-forward ";")
  (backward-char)
  (insert " after 2 ns")
  )

(defun shell-for-p4-client-workspace (workspace-abbrev)
  (interactive)
  (shell)
  (rename-buffer workspace-abbrev)
  (insert "cd /net/cook/raid/workarea/andy/")
  (insert workspace-abbrev)
  (comint-send-input)
  (insert "p4s ")
  (insert workspace-abbrev)
  (comint-send-input)
  (dirs)
  )

(defun shell-show-and-resync-dirs ()
  (interactive)
  (dirs)
  (insert "ds")
  (comint-send-input)
  )

(defun andy-setup-first-shell-buffer ()
  (interactive)
  (shell)
;  (delete-other-windows)
  (local-set-key [f3] 'shell-show-and-resync-dirs)
  (rename-buffer "sh")
  )

(defun set-preferred-buffer-1 ()
  (interactive)
  (setq preferred-buffer-1 (current-buffer))
  (message (concat "preferred-buffer-1 set to buffer " (buffer-name preferred-buffer-1)))
  )

(defun set-preferred-buffer-2 ()
  (interactive)
  (setq preferred-buffer-2 (current-buffer))
  (message (concat "preferred-buffer-2 set to buffer " (buffer-name preferred-buffer-2)))
  )

(defun goto-preferred-buffer-1 ()
  (interactive)
  (switch-to-buffer preferred-buffer-1))

(defun goto-preferred-buffer-2 ()
  (interactive)
  (switch-to-buffer preferred-buffer-2))

;; I tried out the function below to try to automate some steps I do,
;; but it always seemed to fail somewhere around the (compile) step,
;; probably because it is trying to prompt in the minibuffer for a
;; make command.  I'd like it if I could write a function like this
;; that just let (compile) take over the minibuffer like that, and
;; then proceeded after that was done with the rest of the function
;; calls.  How?

;; (defun andys-make ()
;;   (interactive)
;;   ;; TBD-JAF: make this a different name, like preferred-make-buffer
;;   (goto-preferred-buffer-2)
;;   (insert "pushd $MAKE_DIR")
;;   (comint-send-input)
;;   (compile)
;; ;  (other-window)
;; ;  (end-of-buffer)
;;   )

;; I like M-x compile behavior better if it automatically scrolls the
;; output window to the end of the output.
(setq compilation-scroll-output t)

(defun set-preferred-tags-file-1 ()
  (interactive)
  (setq preferred-tags-file-1 (buffer-file-name (current-buffer)))
  (message (concat "preferred-tags-file-1 set to file " preferred-tags-file-1))
  )

(defun set-preferred-tags-file-2 ()
  (interactive)
  (setq preferred-tags-file-2 (buffer-file-name (current-buffer)))
  (message (concat "preferred-tags-file-2 set to file " preferred-tags-file-2))
  )

(defun use-preferred-tags-file-1 ()
  (interactive)
  (visit-tags-table preferred-tags-file-1)
  (message (concat "TAGS file is now " preferred-tags-file-1)))

(defun use-preferred-tags-file-2 ()
  (interactive)
  (visit-tags-table preferred-tags-file-2)
  (message (concat "TAGS file is now " preferred-tags-file-2)))

(defun cpp-re-highlight-buffer ()
  (interactive)
  (cpp-highlight-buffer t))


(defun andy-setup-shell-buffers-for-sbcl ()
  (interactive)
  (shell)
  (delete-other-windows)
  (rename-buffer "sh")
  (split-window-vertically)
  (shell)
  (rename-buffer "sbcl")
  (insert "sbcl")
  (comint-send-input)
  )

(defun andys-cliki ()
  (interactive)
  (insert "(load \"/Users/johnfingerhut/sw/cvs/cliki/andys-example.lisp\")")
  (comint-send-input)
  )

(defun andys-araneida ()
  (interactive)
  (insert "(load \"/Users/johnfingerhut/sw/cvs/araneida/doc/andys-example.lisp\")")
  (comint-send-input)
  (insert "(araneida:start-listening andys-araneida-example::*listener*)")
  (comint-send-input)
  )

(global-set-key "\M-m" 'append-after-delay)

(fset 'add-dcsh-and-con-files-as-dependencies
   [?\C-f ?\C-f ?\C-  ?\C-s ?  ?\C-b ?\C-w ?\C-y ?\C-p ?\C-e ?  ?\\ return tab tab ?\C-y ?. ?d ?c ?s ?h ?  ?\C-y ?. ?c ?o ?n ?\C-n])

(global-set-key "\M-m" 'add-dcsh-and-con-files-as-dependencies)

(fset 'add-dcsh-and-con-as-dependencies2
   [?\C-f ?\C-f ?\C-  ?\C-s ?  ?\C-b ?\C-w ?\C-y ?\C-p ?\C-p ?\C-e ?  ?\\ return tab tab ?\C-y ?. ?d ?c ?s ?h ?  ?\C-y ?. ?c ?o ?n ?\C-n ?\C-n])

(global-set-key "\M-n" 'add-dcsh-and-con-as-dependencies2)

;; I want to know what is going on behind my back with RCS when I
;; use version control on files.  It could be educational.
(setq vc-command-messages t)

;(custom-set-variables
; '(vhdl-stutter-mode nil)
; '(vhdl-electric-mode nil))
;(custom-set-faces
; '(font-lock-comment-face ((nil (:foreground "moccasin"))))
; '(font-lock-type-face ((((class color) (background light)) (:foreground "Green"))))
; '(font-lock-function-name-face ((((class color) (background light)) (:foreground "Cyan")))))

(cond
 (hilit-enabled
  ;(hilit-translate comment 'Goldenrod)
  (hilit-translate comment 'cyan)
  ;(hilit-translate comment 'black/lightblue)
  ;(hilit-translate comment 'black)
  ))

(show-paren-mode 1)
;(andy-setup-first-shell-buffer)

(setq common-lisp-hyperspec-root "file:/Users/Shared/lang/lisp/HyperSpec/")
(setq inferior-lisp-program "sbcl")
;(setq inferior-lisp-program "clisp")

;; clojure-mode
;; The following line is obsoleted by using ELPA to install
;; clojure-mode, as long as the lines that ELPA adds are put before
;; this, e.g. at the beginning of my .emacs file instead of at the
;; end.
;;(append-to-load-path (concat andy-home-dir "/sw/git/clojure-mode"))
(require 'clojure-mode)
(add-hook 'clojure-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    (viper-mode)))

(setq auto-mode-alist (cons '("\\.clojure$" . clojure-mode) auto-mode-alist))

;; WARNING: Something like the following was necessary when I
;; installed and used SLIME with Clojure the first time, around August
;; 2009.  By August 2010, the current version of swank-clojure
;; recommended using 'lein swank' from the command line to start a
;; Clojure process, not from within Emacs (it could be, but need not
;; be), and then use M-x slime-connect to connect to that process.

;; I will keep around the text below at least for now in case it is
;; still useful for using SLIME with SBCL Common Lisp.

(when nil
  ;; Use 'when t' above if you want M-x slime to fire up a Clojure
  ;; inferior process.

  ;; Use 'when nil' above if you want M-x slime to fire up an SBCL
  ;; inferior process.

  ;; swank-clojure
  (append-to-load-path (concat andy-home-dir "/sw/git/swank-clojure"))
  (require 'swank-clojure-autoload)
  (swank-clojure-config
;;   (setq swank-clojure-jar-path (concat andy-home-dir "/.clojure/clojure-1.0.0.jar"))
;;   (setq swank-clojure-extra-classpaths
;;	 (list (concat andy-home-dir "/.clojure/clojure-contrib.jar")))
   (setq swank-clojure-jar-path (concat andy-home-dir "/.clojure/clojure-1.2.0.jar"))
   (setq swank-clojure-extra-classpaths
	 (list (concat andy-home-dir "/.clojure/clojure-contrib-1.2.0.jar")))
   )
  )

(when nil
;(append-to-load-path (concat andy-home-dir "/sw/cvs/slime"))
;(append-to-load-path (concat andy-home-dir "/sw/cvs/2006-10-27-slime/slime"))
;(append-to-load-path (concat andy-home-dir "/sw/cvs/2008-01-29-fairly-stable-slime/slime"))
;(append-to-load-path (concat andy-home-dir "/sw/cvs/2008-01-29-latest-slime/slime"))
;(append-to-load-path (concat andy-home-dir "/sw/cvs/2008-12-02-latest-slime/slime"))
  (eval-after-load "slime"
    '(progn (slime-setup '(slime-repl))))
  (append-to-load-path (concat andy-home-dir "/sw/git/slime"))
  (require 'slime)
  (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
  (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;(slime-setup)
  )


;; Indent Lisp if so that the 'then' part is indented the same as the
;; 'else' part.
(put 'if 'lisp-indent-function 1)

;; Some macros I often define, and would like to be indented like
;; special forms, not like function calls.
(put 'for 'lisp-indent-function 1)
(put 'aif 'lisp-indent-function 1)


(setq viper-mode t)
(require 'viper)

;(setq tramp-default-method "scp")
;(require 'tramp)

(defadvice make-variable-buffer-local (around viper-fix activate)
  "Avoid making minor-mode-map-alist buffer-local."
  (or (eq (ad-get-arg 0) 'minor-mode-map-alist) ad-do-it))


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Scheme indentation customizations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(put 'while 'scheme-indent-function 'defun)
(put 'define 'scheme-indent-function 'defun)
(put 'if 'scheme-indent-function 'defun)

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "mozilla-remote")
 '(c-offsets-alist (quote ((substatement-open . 0))))
 '(cpp-edit-list (quote (("0" font-lock-comment-face default t))))
 '(cpp-known-face (quote default))
 '(cpp-unknown-face (quote default)))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )
