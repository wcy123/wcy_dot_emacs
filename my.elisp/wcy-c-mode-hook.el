;;;###autoload
(defun wcy-c-mode-hook ()
  (setq c-basic-offset 4)
  (set (make-local-variable 'parens-require-spaces) nil)
  (wcy-define-key-in-transient-mode
   nil
   (kbd "C-d")
   #'(lambda(b e) 
       (interactive "r")
       (delete-region b e))
   'c-electric-delete-forward))


