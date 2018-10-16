(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; To add clojure-mode, nrepl, nrepl-ritz, etc., do M-x
;; package-list-packages, find the package name in the resulting
;; buffer containing a list of packages, go to its line, press 'i'
;; to mark it for installation, then 'x' to execute that
;; installation.  A new buffer should appear, and it is normal for
;; it to have compile warnings.  As long as there are no errors, you
;; should be fine.

(setq viper-mode t)
(require 'viper)

(when (= emacs-major-version 23)
  (mwheel-install))

;; Avoid showing the initial startup/splash screen with the gnu on it
(setq inhibit-startup-screen t)

;; In dired mode, show all dirs before non-dir files
(setq ls-lisp-dirs-first t)
(setq dired-listing-switches "-agl")

;; I usually like white space to be ignored when running ediff on two
;; files, since those two files are usually source code in which most
;; white space is indentation.
(defvar ediff-diff-options "-w")
;(defvar ediff-diff-options "")

;; When programming, it is most useful for dynamic abbreviations to
;; match the case of the identifier found elsewhere in the file.
(setq dabbrev-case-replace nil)

;; I don't care if it is slow to display line numbers in large files.
;; It is sometimes extremely handy to have the line number displayed
;; when ediff-ing two large buffers.
;;(setq line-number-display-limit 16000000)
(setq line-number-display-limit nil)

(setq line-number-display-limit-width 1000)

(setq-default ispell-program-name "aspell")
;(setq-default ispell-extra-args '("--reverse"))


(setq enable-local-variables 'query)
(set 'inhibit-local-variables t)


(defun prepend-to-load-path (my-path)
  (cond
   ((file-directory-p my-path)
    (setq load-path (cons (expand-file-name my-path) load-path)))))

(defun append-to-load-path (my-path)
  (cond
   ((file-directory-p my-path)
    (setq load-path (append load-path (list (expand-file-name my-path)))))))


(prepend-to-load-path "/opt/local/share/emacs/site-lisp")
(prepend-to-load-path "/usr/local/share/emacs/site-lisp")
(prepend-to-load-path "~/.emacs.d/lisp")

(let* ((uname-s-output (shell-command-to-string "uname -s")))
  (defvar osx-p (string-prefix-p "Darwin" uname-s-output))
  (defvar linux-p (string-prefix-p "Linux" uname-s-output)))

;; While normally I would use (left . -5) to cause the emacs window to
;; appear a little bit away from the right edge of desktop, when I do
;; that on a Mac with an external display arranged to the right of the
;; built-in screen, the emacs window doesn't show up on either screen.
;; Strange.  765 from the left seems to work well when the
;; built-in-desktop is set to 2880x1800 resolution, but I would guess
;; that Xquartz is using larger pixels than that.
(defvar x-windows-default-frame-left-val (if osx-p 765 -5))

(require 'ido)
(ido-mode t)
(require 'xcscope)
(require 'setnu)
;(require 'andys-projectile)
(require 'andys-helm-ag)


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
  ;;(load-library "vhdl-mode")

  ;; Common actions to perform for any of these window systems, but
  ;; not if we are in text mode.
  (cond ((or (eq window-system 'ns)
	     (eq window-system 'x)
	     (eq window-system 'w32))
	 ;; Turn off the graphical toolbar
	 (tool-bar-mode -1)
	 (menu-bar-mode -1)
	 (scroll-bar-mode -1)))

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
		    ;;(font . "-*-Courier-normal-r-*-*-15-50-*-*-c-*-*-ansi-")
		    (font . "-*-Courier-normal-r-*-*-15-25-*-*-c-*-*-ansi-")
		    ))))
   ((eq window-system 'x)
    (setq default-frame-alist
	  (append default-frame-alist
		  (list '(top . 0) (cons 'left x-windows-default-frame-left-val)
			'(width . 80) '(height . 64)
			'(font . "8x13")
			))))
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
    (setq initial-frame-alist '((top . 0) (left . 5))))
   )))


(require 'andys-c)
(require 'andys-p4)
;; I haven't used this stuff in a while, but make it easy to enable
;(require 'andys-hdls)
;(require 'andys-fortran)
;(require 'andys-haskell)
;(require 'andys-ruby)
;(require 'andys-lua)
;(require 'andys-asm)
;(require 'andys-scheme)
;(require 'andys-asciidoc)
;(require 'andys-cl)


(require 'clojure-mode)
(add-hook 'clojure-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    (viper-mode)))


;; Indent Lisp if so that the 'then' part is indented the same as the
;; 'else' part.
(put 'if 'lisp-indent-function 1)

;; Some macros I often define, and would like to be indented like
;; special forms, not like function calls.
(put 'for 'lisp-indent-function 1)
(put 'aif 'lisp-indent-function 1)


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

;; Add color to a shell running in emacs ‘M-x shell’
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'shell-mode-hook
	  (lambda ()
	    (remove-hook 'comint-output-filter-functions
			 'comint-watch-for-password-prompt)
	    (remove-hook 'comint-output-filter-functions
			 'comint-postoutput-scroll-to-bottom)))

(when font-lock-enabled
  (global-font-lock-mode 1))


;; I like M-x compile behavior better if it automatically scrolls the
;; output window to the end of the output.
(setq compilation-scroll-output t)


;; Not sure if this is necessary, but if I want functions defined
;; above to have key bindings in fn-key-bindings, probably most likely
;; to work if the key bindings are defined after the functions.
(require 'fn-key-bindings)


;; I want to know what is going on behind my back with RCS when I
;; use version control on files.  It could be educational.
(setq vc-command-messages t)

(cond
 (hilit-enabled
  ;(hilit-translate comment 'Goldenrod)
  (hilit-translate comment 'cyan)
  ;(hilit-translate comment 'black/lightblue)
  ;(hilit-translate comment 'black)
  ))

; Turn off the graphical toolbar
(tool-bar-mode -1)
(show-paren-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-follow-mode-persistent t)
 '(package-selected-packages (quote (inf-clojure cider clojure-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
