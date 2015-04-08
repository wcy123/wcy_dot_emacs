;;;###autoload
(defun wcy-kill-emacs()
  "kill emacs when only one frame left, otherwise, delete selected frame"
  (interactive)
  (if (cdr (frame-list))
      (progn
        (mapc #'server-delete-client server-buffer-clients)
        (call-interactively 'delete-frame))
    (call-interactively 'save-buffers-kill-emacs)))
