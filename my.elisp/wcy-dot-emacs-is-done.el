;;;;
;;;###autoload
(defun wcy-dot-emacs-is-done ()
  (format
    "%s"
    (concat ";; dot.emacs is successfully loaded.\n"
	    ";; SYS INIT time: " (format "%s seconds"
					 (float-time
					  (time-subtract
					   (or after-init-time (current-time))
					   before-init-time)))
	    "\n"
	    ";; USER INIT time: " (format "%s seconds"
					  (float-time
					   (time-subtract
					    (current-time)
					    before-init-time)))
	    "\n"
	    (mapconcat
	     (lambda (x)
	       (format ";; spent %5.2f milisecond for loading %s" (* 1000 (cdr x)) (car x)))
	     (sort (copy-list wcy-profile-startup)
		   (lambda (x y) (> (cdr x) (cdr y))))
	     "\n")
	    "\n"
	    )))
