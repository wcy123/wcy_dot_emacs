;;;###autoload
(defun wcy-init-my-package()
  "install all my package."
  (interactive)
  (when (not (file-exists-p (expand-file-name "my.package" my-emacs-home)))
    (make-directory (expand-file-name "my.package" my-emacs-home)))
  (dolist (var
           '(
             ("company-go"
              "https://raw.githubusercontent.com/nsf/gocode/master/emacs-company/company-go.el"
              "company-go.el")
             ("go-errcheck"
              "https://raw.githubusercontent.com/dominikh/go-errcheck.el/master/go-errcheck.el"
              "go-errcheck.el")
             ("color-theme"
              "http://download.savannah.gnu.org/releases/color-theme/color-theme.el.gz"
              "color-theme.el.gz")
             ("color-theme-solarized"
              "https://raw.githubusercontent.com/altercation/solarized/master/emacs-colors-solarized/color-theme-solarized.el"
              "color-theme-solarized.el")
             ("cmake-mode"
              "https://cmake.org/gitweb?p=cmake.git;a=blob_plain;hb=master;f=Auxiliary/cmake-mode.el"
              "cmake-mode.el"
              )
             ("multi-term"
              "http://www.emacswiki.org/emacs/download/multi-term.el"
              "multi-term.el"
              )
             ("avy"
              "https://raw.githubusercontent.com/abo-abo/avy/master/avy.el"
              "avy.el")
             ("ace-window"
              "https://raw.githubusercontent.com/abo-abo/ace-window/master/ace-window.el"
              "ace-window.el"
              )))
    (apply #'wcy-init-my-package-simple var)))
(defun wcy-init-my-package-simple(name url filename)
  (if (not (locate-file name load-path '(".elc" ".el" ".el.gz")))
      (with-temp-message (format "retrieving %s" url)
        (sit-for 0)
        (let* ((default-directory (expand-file-name "my.package" my-emacs-home))
               (full-name (expand-file-name filename))
               (ret (call-process "curl" nil nil nil
                                  "-Lo"
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
