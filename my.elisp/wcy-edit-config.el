;;;###autoload
(defun wcy-edit-config ()
  "edit dot.emacs in my.config."
  (interactive)
  (find-file (expand-file-name
              "dot.emacs"
              my-config-path)))
;;;###autoload
(defun wcy-edit-config-experimental ()
  "edit dot.emacs in my.elisp.experimental"
  (interactive)
  (find-file (expand-file-name
              "dot.emacs"
              my-elisp-experimental-path)))
;;;###;;;###autoload
(defun wcy-edit-config-system-specific ()
  "edit dot.emacs in my.elisp"
  (interactive)
  (find-file
   (expand-file-name
    (format "dot.emacs.%s.el"
	    (wcy-make-canonical-file-name system-type))
    my-config-path)))
;;;###autoload
(defun wcy-edit-abbrev ()
  "edit abbrevs"
  (interactive)
  (find-file abbrev-file-name)
  (add-hook 'after-save-hook
	    #'(lambda ()
		(kill-all-abbrevs)
		(quietly-read-abbrev-file))
	    t t))
;;;###autoload
(defun wcy-edit-my-elisp ()
  "edit my elisp"
  (interactive)
  (find-file my-elisp-path))
;;;###autoload
(defun wcy-edit-ac ()
  "edit abbrevs"
  (interactive)
  (find-file (expand-file-name
              (concat "wcy-ac/" (symbol-name major-mode))
              my-data-path)))
;;;###autoload
(defun wcy-edit-build-sh ()
  "edit abbrevs"
  (interactive)
  (find-file (expand-file-name "~/.build.sh"
                               my-data-path)))
