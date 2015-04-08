;; -------------------- less often used, but useful ----
;;;###autoload
(defun wcy-update-my.elisp-directory-autoloads ()
  (interactive)
  (let ((generated-autoload-file (expand-file-name ".loaddefs.el" my-config-path)))
    (when (funcall
           (\.
            ($ notevery ($ file-newer-than-file-p generated-autoload-file))
            ($ remove-if-not (\. ($ string= ".el") ($ (wcy-flip substring) -3)))
            ($ apply #'append)
            ($ mapcar #'(lambda (d) (directory-files d t nil t))))
           (list my-elisp-path))
      (dolist (path (list my-elisp-path))
        (update-directory-autoloads path)
        (byte-recompile-directory path)))
    (load-file generated-autoload-file)))
