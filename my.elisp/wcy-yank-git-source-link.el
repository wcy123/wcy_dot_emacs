(defun wcy-yank-git-source-link (&optional begin end)
    "yank the http link to github."
    (interactive "r")
    (let* ((range (wcy-yank-git-source-link-get-range begin end))
           (begin-line (car range))
           (end-line (cdr range))
           (git-ignore (or (wcy-search-file-in-parent-dir '(".gitignore") ".")
                           (error "cannot find git root directory")))
           (root-dir (file-name-directory git-ignore))
           (relative-name (file-relative-name (buffer-file-name) root-dir))
           ;; https://github.com/wcy123/ejabberd/blob/dcf5aefea0363cc96d404591696e306fc323d8f5/src/ejabberd_app.erl#L47
           (git-remote-url (trim
                            (shell-command-to-string "git remote -v show | awk '{print $2}' | head -n1")))
           (sha1 (trim (shell-command-to-string "git rev-parse HEAD")))
           (link
            (concat git-remote-url "/blob/"
                    sha1 "/"
                    relative-name
                    (format "#L%d-#L%d" begin-line end-line))))
      (message "%S" link)
      ))
(defun wcy-yank-git-source-link-get-range (begin end)
  (if mark-active
      (cons (line-number-at-pos begin) (line-number-at-pos end))
    (cons (line-number-at-pos (point)) (line-number-at-pos (point)))))
(defun trim (string)
  (replace-regexp-in-string
   "\\`[ \n\t]*\\(.*\\)[ \n\t]*\\'"
   "\\1"
   string))
