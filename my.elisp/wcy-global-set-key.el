;;;###autoload 
(defun wcy-global-set-key (&rest keys)
  (while keys
    (global-set-key (read-kbd-macro (car keys)) (cadr keys))
    (setq keys (cddr keys))))