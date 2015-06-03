;;;###autoload
(defun wcy-insert-date-time ()
  "insert date and time"
  (interactive)
  (insert (format-time-string "%Y/%m/%d %H:%M:%S")))
