;;;###autoload 
(defun  wcy-read-variable (prompt predicate &optional default)
  "read a varable"
  (let ((v (variable-at-point)))
    (when (and (symbolp v)
	       (boundp v)
	       (null (funcall predicate v)))
      (setq v 0)))
  (completing-read 
   prompt
   obarray
   `(lambda (vv)
      (and (boundp vv)
	   (funcall ,predicate  vv)))
   t  ;; require match
   nil  ;; initial-input
   nil ;; history
   default
   ))
  
