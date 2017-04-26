;;;###autoload
(defun wcy-load-ssh-env()
    "load env from a file, mainly used for tmux attach and reset environmen for
ssh -A"
    (interactive)
    (with-temp-buffer
      (insert-file-contents "~/.ssh/latestagent")
      (beginning-of-buffer)
      (while (re-search-forward "^EXPORT \\(.*\\)=\\(.*\\)" nil t nil)
        (let ((env-name (match-string 1))
              (env-value (match-string 2)))
          (setenv env-name env-value)))))
