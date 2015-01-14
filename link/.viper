;; I've forgotten what all of these do, but it should be possible to
;; get full documentation for any of the variables by typing
;; <Control-h> v name-of-variable <Return> inside of Emacs.

(setq viper-no-multiple-ESC nil)
(setq viper-want-ctl-h-help t)
(setq viper-ex-style-motion nil)
(setq viper-inhibit-startup-message  't)
(setq viper-case-fold-search t)
(setq viper-expert-level '5)

;; I think that the default vi/VIPER bindings for SPC and RET are
;; silly, given that "l" and "j0" work just fine.  I have gotten used
;; to the bindings of these keys used by another Emacs vi mode, which
;; are SPC for page forward and RET for page backward.

(define-key viper-vi-global-user-map " " 'scroll-up)
(define-key viper-vi-global-user-map [return] 'scroll-down)
;; The binding for [return] seems only to work on X server keyboards.
;; The one below works for a terminal connection from home.
(define-key viper-vi-global-user-map "\C-m" 'scroll-down)

;; I like Control-N to switch between Emacs buffers, like Control-X o
;; does, except that it's shorter.

(define-key viper-vi-global-user-map "\C-n" 'other-window)

;; I also like a single keystroke way to switch to another buffer by
;; name, rather than having to use Control-X b

(define-key viper-vi-global-user-map "s" 'switch-to-buffer)

;; And this is shorter than Control-X 4 b for switching to a buffer in
;; another window.

(define-key viper-vi-global-user-map "S" 'switch-to-buffer-other-window)
