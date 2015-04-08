;;;###autoload
(defun wcy-display-buffer-name ()
  (interactive)
  (message (or (buffer-file-name (current-buffer))
               (format "%s[%s]" default-directory (buffer-name)))))
