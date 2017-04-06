;;;###autoload
(defun atom()
  "open current file with atom"
  (interactive)
  (call-interactively 'save-buffer)
  (start-process "atom" nil "atom" buffer-file-name))
