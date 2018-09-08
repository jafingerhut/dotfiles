(defun list-buffers-then-other-window ()
  (interactive)
  (list-buffers)
  (other-window 1)
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


(defun revert-buffer-no-confirm ()
  (interactive)
  (revert-buffer t t))



(global-set-key [(control shift f1)]   'andy-setup-first-shell-buffer)

;; It might be nice to have a hard-to-type function key to switch
;; between cscope, TAGS, and gid special keys, all overlaid on the
;; same function keys, but only one of them usable at a time.

;; cscope - functions provided by xcscope.el I believe

(global-set-key [f1] 'cscope-find-global-definition)
(global-set-key [(shift f1)] 'cscope-find-this-symbol)
(global-set-key [f2] 'cscope-find-functions-calling-this-function)
(global-set-key [(shift f2)] 'cscope-find-called-functions)

(global-set-key [f3]    'revert-buffer-no-confirm)
(global-set-key [(shift f3)]    'ediff-buffers)

(global-set-key [f4]     'inf-clojure-eval-last-sexp)
(global-set-key [(control shift f4)]     'inf-clojure-minor-mode)

;; really handy to avoid me typing C-x C-b C-x o If I ever get used to
;; another way to switch between buffers, I might not use this any
;; more.
(global-set-key [f5]    'list-buffers-then-other-window)
(global-set-key [(shift f5)]    'delete-other-windows)  ; normally C-x 1
(when (= emacs-major-version 23)
  (global-set-key [(control f5)]    'split-window-vertically))  ; normally C-x 2
(when (= emacs-major-version 24)
  (global-set-key [(control f5)]    'split-window-below))  ; normally C-x 2

(global-set-key [f6]    'other-window)
(global-set-key [(shift f6)]    'other-frame)
(global-set-key [(control f6)]    'compile)

(global-set-key [f7]    'save-buffer)

;; f8 - on Cisco Mac when running RealVNC, bound to open a popup menu
;; for VNC
;(global-set-key [f8]    'used-for-realvnc-dont-set-me)

(global-set-key [(shift f8)]    'occur)

(global-set-key [(shift f9)] 'compilation-mode)
(global-set-key [f9]    'previous-error)
(global-set-key [f10]   'next-error)

(global-set-key [(control shift f11)]   'set-preferred-buffer-1)
(global-set-key [f11]   'goto-preferred-buffer-1)
(global-set-key [(control shift f12)]   'set-preferred-buffer-2)
(global-set-key [f12]   'goto-preferred-buffer-2)


;; Do I currently rely on these?  I probably do, but maybe test.

(define-key Buffer-menu-mode-map "n" 'next-line)
(define-key Buffer-menu-mode-map "p" 'previous-line)

;; The following key bindings are reasonable on my numeric keypad, but
;; may be different on your keyboard.  I am keeping them here in
;; comments not because I use the functions they are bound to on
;; function keys, but in case I have a keyboard with numeric keypad at
;; some point in time and want to remember how to do this.

;(global-set-key [f27]   'beginning-of-buffer)
;(global-set-key [f29]   'scroll-down)
;(global-set-key [f33]   'end-of-buffer)
;(global-set-key [f35]   'scroll-up)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions that I have sometimes bound to particular keys, but I
;; don't currently use often enough to justify doing so.

;(defun cpp-re-highlight-buffer ()
;  (interactive)
;  (cpp-highlight-buffer t))

;(global-set-key [f1]    'indent-region)
;(global-set-key [f3]    'clipboard-kill-ring-save)
;(global-set-key [(control shift f3)]    'cpp-re-highlight-buffer)
;(global-set-key [f4]    'clipboard-yank)
;(global-set-key [f4]    'delete-matching-lines)
;(global-set-key [f5]    'compile)
;(global-set-key [f8]    'anything)
;(global-set-key [f9]    'insert-latexmath)
;(global-set-key [f12]   'insert-verilog-assertion)

;(global-set-key [(alt n)]      'comint-next-input)
;(global-set-key [(alt p)]      'comint-previous-input)

;(global-set-key [f4]    'common-lisp-hyperspec)
;(global-set-key [(control f7)]   'slime-compile-and-load-file)
;(global-set-key [(control f8)]   'slime-compile-defun)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TAGS

;(fset 'find-next-tag-viper
;   "1\M-.")
;(fset 'find-next-tag-non-viper
;   "\C-u\M-.")

;(defun set-preferred-tags-file-1 ()
;  (interactive)
;  (setq preferred-tags-file-1 (buffer-file-name (current-buffer)))
;  (message (concat "preferred-tags-file-1 set to file " preferred-tags-file-1))
;  )

;(defun set-preferred-tags-file-2 ()
;  (interactive)
;  (setq preferred-tags-file-2 (buffer-file-name (current-buffer)))
;  (message (concat "preferred-tags-file-2 set to file " preferred-tags-file-2))
;  )

;(defun use-preferred-tags-file-1 ()
;  (interactive)
;  (visit-tags-table preferred-tags-file-1)
;  (message (concat "TAGS file is now " preferred-tags-file-1)))

;(defun use-preferred-tags-file-2 ()
;  (interactive)
;  (visit-tags-table preferred-tags-file-2)
;  (message (concat "TAGS file is now " preferred-tags-file-2)))

;(global-set-key [f1] 'tags-search)
;(global-set-key [f2] 'tags-loop-continue)
;(global-set-key [f11]   'find-next-tag-viper)
;(global-set-key [f7]    'find-next-tag-non-viper)
;(global-set-key [f12]   'find-tag-other-window)
;(global-set-key [(control shift f9)]   'set-preferred-tags-file-1)
;(global-set-key [(control f9)]   'use-preferred-tags-file-1)
;(global-set-key [(control shift f10)]   'set-preferred-tags-file-2)
;(global-set-key [(control f10)]   'use-preferred-tags-file-2)

;; gid - when did I use this?

;(global-set-key [(control f2)] 'gid)
;(global-set-key [(control f2)] 'gid32)


(provide 'fn-key-bindings)
