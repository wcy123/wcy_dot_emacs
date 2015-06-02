;;;###autoload
(defun wcy-init-my-package()
  "install all my package."
  (interactive)
  (when (not (file-exists-p (expand-file-name "my.package" my-emacs-home)))
    (make-directory (expand-file-name "my.package" my-emacs-home)))
  (dolist (var
	   '(("ace-jump-mode" "https://raw.githubusercontent.com/winterTTr/ace-jump-mode/master/ace-jump-mode.el"
	      "ace-jump-mode.el")
	     ("session" "http://www.emacswiki.org/emacs/download/session.el"
	      "session.el")
	     ("markdown-mode" "http://jblevins.org/projects/markdown-mode/markdown-mode.el"
	      "markdown-mode.el")
	     ("xcscope" "https://raw.githubusercontent.com/dkogan/xcscope.el/master/xcscope.el"
	      "xcscope.el"
	      )
             ("solarized"
              "https://raw.githubusercontent.com/altercation/solarized/master/emacs-colors-solarized/color-theme-solarized.el"
              "color-theme-solarized.el")
             ))
    (apply #'wcy-init-my-package-simple var)))
(defun wcy-init-my-package-simple(name url filename)
  (if (not (locate-file name load-path '(".elc" ".el")))
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
	    (warn "cannot retrieve %s" url))))
    (message "%s is already installed" name)))
