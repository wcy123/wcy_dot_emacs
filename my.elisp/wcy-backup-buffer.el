;;;###autoload
(defun wcy-backup-buffer()
  (interactive)
  (if (buffer-file-name)
    (write-region 1 (1+ (buffer-size)) 
                  (concat (file-name-sans-extension (buffer-file-name))
			  (format-time-string "_%Y_%m_%d.%H.%M.%S")
			  "."
			  (file-name-extension (buffer-file-name))))
    (message "buffer has no file associate.")))