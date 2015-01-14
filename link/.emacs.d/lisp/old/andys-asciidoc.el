(defun insert-latexmath ()
  (interactive)
  (insert "latexmath:[$$]")
  (backward-char 2)
  )

(provide 'andys-asciidoc)
