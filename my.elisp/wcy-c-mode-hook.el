;;;###autoload
(defun wcy-c-mode-hook ()
  (setq c-basic-offset 4)
  (set (make-local-variable 'parens-require-spaces) nil))


