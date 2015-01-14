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
