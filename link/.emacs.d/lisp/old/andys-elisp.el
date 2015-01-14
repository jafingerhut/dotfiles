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

