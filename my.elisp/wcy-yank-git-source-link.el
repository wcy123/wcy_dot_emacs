(defun wcy-yank-git-source-link (&optional begin end)
    "yank the http link to github."
    (interactive "r")
    (let* ((range (wcy-yank-git-source-link-get-range begin end))
           (begin-line (car range))
           (end-line (cdr range))
           (text (buffer-substring begin end))
           (label (ff-text text))
           (git-ignore (or (wcy-search-file-in-parent-dir '(".gitignore") ".")
                           (error "cannot find git root directory")))
           (root-dir (file-name-directory git-ignore))
           (relative-name (file-relative-name (buffer-file-name) root-dir))
           ;; https://github.com/wcy123/ejabberd/blob/dcf5aefea0363cc96d404591696e306fc323d8f5/src/ejabberd_app.erl#L47
           (git-remote-url (get-git-remote-url))
           (sha1 (trim (shell-command-to-string "git rev-parse HEAD")))
           (link
            (concat git-remote-url "/blob/"
                    sha1 "/"
                    relative-name
                    (format "#L%d-#L%d" begin-line end-line))))
      (kill-new (format "[%s](%s)" label link))
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

(defun ff-text (text)
  (let ((text1 (trim text)))
    (cond
     ((> (length text1) 128)
      (let* ((text2 (replace-regexp-in-string "[ \t\n]+" "." text1)))
        ;; replace very long text with "..." in the middle
        (replace-regexp-in-string "\\`\\(.\\{64\\}\\).*\\(.\\{64\\}\\)\\'"
                                  "\\1 ... \\2" text2)))
     ((find ?\n text1)
      (replace-regexp-in-string "[ \t\n]+" "." text1))
     (t text1))))
(defun get-git-remote-url ()
  (let ((url (trim (shell-command-to-string "git remote -v show | awk '{print $2}' | head -n1"))))
    (if (not (string-match ".*/github\\.com.*\\.git\\'" url))
        url
      (substring url 0 -4))))
