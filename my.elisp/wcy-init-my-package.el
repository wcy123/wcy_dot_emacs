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
         ("company-go"
          "https://raw.githubusercontent.com/nsf/gocode/master/emacs-company/company-go.el"
          "company-go.el")
         ("go-errcheck"
          "https://raw.githubusercontent.com/dominikh/go-errcheck.el/master/go-errcheck.el"
          "go-errcheck.el")
         ("color-theme"
          "http://download.savannah.gnu.org/releases/color-theme/color-theme.el.gz"
          "color-theme.el.gz")
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
                  (let* ((ext (file-name-extension full-name))
                         (full-name-2 (if (string= ext "gz")
                                          (file-name-sans-extension full-name)
                                        full-name)))
                    (when (string= ext "gz")
                      (call-process "gunzip" nil nil nil
                                    full-name))
                    (byte-compile-file full-name))
                (warn "cannot retrieve %s" url)))))
    (message "%s is already installed" name)))
