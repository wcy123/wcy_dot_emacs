;;;###autoload
(defun wcy-c-mode-hook ()
  ;;(setq c-basic-offset 4)
  ;; prevent extern "C" { indenting
  (c-set-offset 'inextern-lang 0)
  (set (make-local-variable 'parens-require-spaces) nil))
