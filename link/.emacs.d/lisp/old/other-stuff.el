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


;;(setq compilation-error-regexp-alist
;;      (cons
;;       ;; Verilint
;;       ;; (W180)  qm_rfp_bb_gse.v, line 289: Zero extension of extra bits: q1_head
;;       '("\\([(][A-Za-z]+[0-9]+[)]\\)\\([ ]+\\)\\([^ \n]*\\), line \\([0-9]+\\):" 3 4)
;;       compilation-error-regexp-alist))


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
