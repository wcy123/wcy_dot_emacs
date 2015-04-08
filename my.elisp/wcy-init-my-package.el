;;;###autoload
(defun wcy-init-my-package()
  "install all my package."
  (interactive)
  (when (not (file-exists-p (expand-file-name "my.package" my-emacs-home)))
    (make-directory (expand-file-name "my.package" my-emacs-home)))
  (wcy-init-my-package-simple
   "https://raw.githubusercontent.com/winterTTr/ace-jump-mode/master/ace-jump-mode.el"
   "ace-jump-mode.el")
  (when (not (locate-file "session" load-path '(".elc" ".el")))
    (wcy-init-my-package-simple
     "http://www.emacswiki.org/emacs/download/session.el"
     "session.el")))
(defun wcy-init-my-package-simple(url filename)
  (with-temp-message (format "retrieving %s" url)
    (sit-for 0)
    (let* ((default-directory (expand-file-name "my.package" my-emacs-home))
	   (full-name (expand-file-name filename))
	   (ret (call-process "curl" nil nil nil
			      "-o"
			      full-name
			      url)))
      (if (eq ret 0)
	  (condition-case nil
	      (byte-compile-file full-name))
	(warn "cannot retrieve %s" url)))))
    
