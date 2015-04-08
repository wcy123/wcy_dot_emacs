;;;###autoload 
(defun wcy-add-local-variable-for-file ()
  (interactive)
  (save-excursion
    (end-of-buffer)
    (let (x-point ypoint)
      (setq x-point (point))
      (insert "\n")
      (insert "\nLocal Variables:")
      (let (start end)
        (setq start (+ (point) 5))
        (insert "\nmode:" (symbol-name major-mode))
        (setq end (point))
        (replace-string "-mode" "" nil start end)
        (insert (format "\ncoding: %S" buffer-file-coding-system)))
    (insert "\nEnd:\n")
    (setq y-point (point))
    (comment-region x-point y-point))
    nil))


;; Local Variables:
;; mode:emacs-lisp
;; End:
