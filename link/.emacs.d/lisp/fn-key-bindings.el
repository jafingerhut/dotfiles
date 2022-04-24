(require 'thingatpt)

(defalias 'er 'eval-region)

;(defun viper-debug-word-at-point ()
;  (interactive)
;  ;(setq viper-s-string (word-at-point))
;  (setq viper-s-string (symbol-at-point))
;  (message "Doing tags search on '%s'..." viper-s-string)
;  )

;; If the current window is not the only one in its frame, behave like
;; delete-other-windows (by default bound to C-x 1), so it becomes the
;; only one in its frame.

;; If the current window is the only one in its frame, behave like
;; split-window-below (by default bound to C-x 2).
(defun delete-other-windows-or-split-window-below ()
  (interactive)
  (cond
   ((= 1 (length (window-list)))
    (split-window-below))
   (t
    (delete-other-windows))))

(defun list-buffers-then-other-window ()
  (interactive)
  (list-buffers)
  (other-window 1))

(defun set-preferred-buffer-1 ()
  (interactive)
  (setq preferred-buffer-1 (current-buffer))
  (message (concat "preferred-buffer-1 set to buffer " (buffer-name preferred-buffer-1))))

(defun set-preferred-buffer-2 ()
  (interactive)
  (setq preferred-buffer-2 (current-buffer))
  (message (concat "preferred-buffer-2 set to buffer " (buffer-name preferred-buffer-2))))

(defun goto-preferred-buffer-1 ()
  (interactive)
  (switch-to-buffer preferred-buffer-1))

(defun goto-preferred-buffer-2 ()
  (interactive)
  (switch-to-buffer preferred-buffer-2))

(defun andy-setup-first-shell-buffer ()
  (interactive)
  (shell)
;  (delete-other-windows)
  (local-set-key [f3] 'shell-show-and-resync-dirs)
  (rename-buffer "sh")
  (set-preferred-buffer-1))


(defun revert-buffer-no-confirm ()
  (interactive)
  (revert-buffer t t))

(defun occur-for-symbol-at-point ()
  "Do occur on the symbol at point"
  (interactive)
  (let ((sname (symbol-name (symbol-at-point))))
    (occur sname)))

(defun ag-project-for-symbol-at-point-and-enable-follow-mode ()
  "Do ag-project for the symbol at point, switch to the search
result buffer, then enable next-error-follow-minor-mode"
  (interactive)
  (let ((sname (symbol-name (symbol-at-point))))
    (ag-project sname)
    (other-window 1)
    (next-error-follow-minor-mode)
    (beginning-of-buffer)))

(defun inf-clojure-connect-localhost-50505 ()
  (interactive)
  (inf-clojure-connect "localhost" 50505))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; comint-echo-and-send-string is a slight modification of
;; comint-send-string, copied from comint.el.  It calls
;; insert-before-markers so that the string sent to the process
;; definitely appears within the comint buffer.  This can be useful
;; for a subprocess that does not echo its input, and we want to send
;; commands copied from other buffers to the comint buffer, and see
;; which commands were run when looking at the history.
(defun comint-echo-and-send-string (process string)
  "Like `process-send-string', but also does extra bookkeeping for Comint mode."
  (if process
      (with-current-buffer (if (processp process)
			       (process-buffer process)
			     (get-buffer process))
	(comint-snapshot-last-prompt)
	(insert-before-markers string))
    (comint-snapshot-last-prompt))
  (process-send-string process string))

;; All functions with inf-clojure in their name below were copied from
;; inf-clojure.el, then modified in some way.  Some were simply
;; changed to call the new version with "echo-and" in its name, but
;; some have undergone larger changes since they were copied.
;; inf-clojure--echo-and-send-string (renamed from
;; inf-clojure--echo-and-send-region) was also modified to preserve
;; the original string, no longer sending the 'sanitized' version
;; returned by inf-clojure--sanitize-command

(defun inf-clojure--echo-and-send-string (proc string)
  "A custom `comint-input-sender` / `comint-send-string`.
It performs the required side effects on every send for PROC and
STRING (for example set the buffer local REPL type).  It should
always be preferred over `comint-send-string`.  It delegates to
`comint-simple-send` so it always appends a newline at the end of
the string for evaluation.  Refer to `comint-simple-send` for
customizations."
  ;; This used to be defined in a 20190531.1511 version of inf-clojure
  ;; that I ws using, but is not defined in inf-clojure version
  ;; 20220421.559.
  ;;(inf-clojure--set-repl-type proc)
  (let ((sanitized (inf-clojure--sanitize-command string)))
    (inf-clojure--log-string sanitized "----CMD->")
    (comint-echo-and-send-string proc (concat string "\n"))))

(defun inf-clojure-echo-and-eval-string (str &optional and-go)
  "Send the string to the inferior Clojure process.
Prefix argument AND-GO means switch to the Clojure buffer afterwards."
  (interactive "r\nP")
  (inf-clojure--echo-and-send-string (inf-clojure-proc) str)
  (when and-go (inf-clojure-switch-to-repl t)))

(defun remove-newlines-at-end (str)
  (replace-regexp-in-string "[\n]+\\'" "" str))

(defun sexp-before-point ()
  (let ((start (save-excursion (backward-sexp) (point)))
	(end (point)))
    (remove-newlines-at-end (buffer-substring-no-properties start end))))

(defun inf-clojure-echo-and-eval-last-sexp (&optional and-go)
  "Send the previous sexp to the inferior Clojure process.
Prefix argument AND-GO means switch to the Clojure buffer afterwards."
  (interactive "P")
  (inf-clojure-echo-and-eval-string (sexp-before-point) and-go))

;; I copied the idea for function wrap-clojure-code-in-rebl-submit
;; from Sean Corfield's corresponding code he wrote for the Atom
;; editor, function "wrap_in_rebl_submit" in this file:
;; https://github.com/seancorfield/atom-chlorine-setup/blob/master/init.coffee

(defun wrap-clojure-code-in-rebl-submit (code-str)
  (concat "(let [value " code-str "] "
	  "(try"
	  "  ((requiring-resolve 'cognitect.rebl/submit) '" code-str " value)"
	  "  (catch Throwable _))"
	  " value)"))

(defun inf-clojure-echo-and-eval-last-sexp-to-rebl (&optional and-go)
  "Send the previous sexp to the inferior Clojure process.
Prefix argument AND-GO means switch to the Clojure buffer afterwards."
  (interactive "P")
  (inf-clojure-echo-and-eval-string (wrap-clojure-code-in-rebl-submit
				     (sexp-before-point))
				    and-go))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key [(control shift f1)]   'andy-setup-first-shell-buffer)

(global-set-key [(control f1)] 'execute-extended-command)

(global-set-key [f1]             'ace-jump-buffer)
(global-set-key [(shift f1)]     'ace-jump-buffer-other-window)

(define-key viper-vi-global-user-map "s" 'ace-jump-buffer)
(define-key viper-vi-global-user-map "S" 'ace-jump-buffer-other-window)

;; This is my modified version of inf-clojure-eval-last-sexp that
;; _does_ copy the expression to evaluate into the *inf-clojure*
;; buffer, so one can see the expressions being evaluated in the
;; interaction history.
(global-set-key [f2]             'inf-clojure-echo-and-eval-last-sexp)
;; This is the version included with inf-clojure that does _not_ copy
;; the expression to evaluate into the *inf-clojure* buffer.  This can
;; be useful for large expressions to evaluate, that I do not want
;; cluttering up the buffer contents.
;;(global-set-key [(control f2)]   'inf-clojure-eval-last-sexp)
(global-set-key [(control f2)]   'inf-clojure-echo-and-eval-last-sexp-to-rebl)
(global-set-key [(shift f2)]     'inf-clojure-set-ns)
(global-set-key [(control shift f2)]   'inf-clojure-connect-localhost-50505)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; These are nice functions to have bound to fn keys when I want to
;; use cscope or TAGS, but I switch buffers in Emacs by selecting them
;; from a list so often that I'd like to keep that key very easy to
;; reach, to change my keyboard usage habits.

;; It might be nice to have a hard-to-type function key to switch
;; between cscope, TAGS, and gid special keys, all overlaid on the
;; same function keys, but only one of them usable at a time.

;; cscope - functions provided by xcscope.el I believe

;;(global-set-key [f1] 'cscope-find-global-definition)
;;(global-set-key [(shift f1)] 'cscope-find-this-symbol)
;;(global-set-key [f2] 'cscope-find-functions-calling-this-function)
;;(global-set-key [(shift f2)] 'cscope-find-called-functions)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key [f3]    'revert-buffer-no-confirm)
(global-set-key [(shift f3)]    'ediff-buffers)

(global-set-key [f4]    'delete-other-windows-or-split-window-below)

;;(global-set-key [f5]    'delete-other-windows)  ; normally C-x 1
;; really handy to avoid me typing C-x C-b C-x o If I ever get used to
;; another way to switch between buffers, I might not use this any
;; more.
;;(global-set-key [(shift f5)]    'list-buffers-then-other-window)
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

;;(global-set-key [(shift f9)] 'compilation-mode)
(global-set-key [f9]    'previous-error)
(global-set-key [f10]   'next-error)

;; Check out this tip some time.  The entire ergoemacs.org site looks
;; interesting.
;; http://ergoemacs.org/emacs/emacs_alias.html

;; Found this page with the suggestions below for modifying behavior of isearch-
;; http://ergoemacs.org/emacs/emacs_isearch_by_arrow_keys.html

;; set arrow keys in isearch. left/right is backward/forward,
;; up/down is history. press Return to exit
(define-key isearch-mode-map (kbd "<up>") 'isearch-ring-retreat)
(define-key isearch-mode-map (kbd "<down>") 'isearch-ring-advance)
(define-key isearch-mode-map (kbd "<left>") 'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "<right>") 'isearch-repeat-forward)
(define-key minibuffer-local-isearch-map (kbd "<left>") 'isearch-reverse-exit-minibuffer)
(define-key minibuffer-local-isearch-map (kbd "<right>") 'isearch-forward-exit-minibuffer)

;; I am not sure in what Emacs version the command
;; isearch-forward-symbol-at-point was added, but I have tried it in
;; versions as old as 24.5.1 and it seems to be present.
(global-set-key [(shift f10)]   'isearch-forward-symbol-at-point)
(global-set-key [(control f10)]  'occur-for-symbol-at-point)
(global-set-key [(control shift f10)]  'ag-project-for-symbol-at-point-and-enable-follow-mode)

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

(defun tags-search-symbol-at-point ()
  "Do tags-search for the symbol at point"
  (interactive)
  (let ((sname (symbol-name (symbol-at-point))))
    (message "Doing tags search on '%s'..." sname)
    (tags-search sname)))

;;; View tags other window
(defun view-tag-other-window (tagname &optional next-p regexp-p)
  "Same as `find-tag-other-window' but doesn't move the point"
  (interactive (find-tag-interactive "View tag other window: "))
  (let ((window (get-buffer-window)))
    (find-tag-other-window tagname next-p regexp-p)
    (recenter 10)
    (select-window window)))

(defun view-tag-symbol-at-point-other-window ()
  "Do view-tag-other-window for the symbol at point"
  (interactive)
  (let ((sname (symbol-name (symbol-at-point))))
    (view-tag-other-window sname)))

;;(fset 'find-next-tag-viper
;;   "1\M-.")

;;(fset 'find-next-tag-non-viper
;;   "\C-u\M-.")

;; I have tried find-previous-tag and find-next-tag, but am not sure
;; in what situations they do something useful for me.
(defun find-previous-tag ()
  (interactive)
  (find-tag nil '-))

(defun find-next-tag ()
  (interactive)
  (find-tag nil t))

(defun set-preferred-tags-file-1 ()
  (interactive)
  (setq preferred-tags-file-1 (buffer-file-name (current-buffer)))
  (message (concat "preferred-tags-file-1 set to file " preferred-tags-file-1)))

(defun set-preferred-tags-file-2 ()
  (interactive)
  (setq preferred-tags-file-2 (buffer-file-name (current-buffer)))
  (message (concat "preferred-tags-file-2 set to file " preferred-tags-file-2)))

(defun use-preferred-tags-file-1 ()
  (interactive)
  (visit-tags-table preferred-tags-file-1)
  (message (concat "TAGS file is now " preferred-tags-file-1)))

(defun use-preferred-tags-file-2 ()
  (interactive)
  (visit-tags-table preferred-tags-file-2)
  (message (concat "TAGS file is now " preferred-tags-file-2)))

(defun andy-define-tags-fn-keys ()
  "Define several function key bindings for useful operations on tags."
  (interactive)
  ;;(global-set-key [f1] 'tags-search-symbol-at-point)
  (global-set-key [f1] 'view-tag-symbol-at-point-other-window)
  (global-set-key [f2] 'tags-loop-continue)
  ;; I haven't been able
  ;;(global-set-key [f9] 'find-previous-tag)
  ;;(global-set-key [f10] 'find-next-tag)
  )

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
