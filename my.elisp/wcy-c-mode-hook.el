;;;###autoload
(defun wcy-c-mode-hook ()
  (setq c-basic-offset 4)
  ;; prevent extern "C" { indenting
  (c-set-offset 'inextern-lang 0)
  (add-hook 'before-save-hook 'delete-trailing-whitespace t t)
  (set (make-local-variable 'parens-require-spaces) nil))


