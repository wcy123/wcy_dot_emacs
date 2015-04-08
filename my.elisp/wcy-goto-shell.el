;;;###autoload
(defun wcy-toggle-shell-and-cd (arg)
  (interactive "p")
  (let ((dir default-directory))
    (wcy-goto-shell arg)
    (funcall comint-input-sender 
           (get-buffer-process (current-buffer)) 
           (concat "cd \"" (expand-file-name dir) "\""))
    (setq default-directory dir)))
;;;###autoload
(defun wcy-toggle-shell (arg)
  (interactive "p")
  (wcy-goto-shell arg))
;;;---------------------------------------
(defun wcy-goto-shell (arg)
  (shell (wcy-goto-shell-get-buffer arg)))
(defun wcy-goto-shell-get-buffer(arg)
  (get-buffer-create (format "*wcy shell %s*" arg)))

(require 'shell)
