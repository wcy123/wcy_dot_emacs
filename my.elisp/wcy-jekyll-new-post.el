;;;###autoload
(defun wcy-jekyll-new-post (title)
  ""
  (interactive "sTitle: ")
  (let ((dir 
         (if (string=
              (file-name-nondirectory (substring (file-name-directory default-directory)
                                                 0 -1))
              "_posts")
             (expand-file-name  ".." default-directory)
           default-directory)))
    (let ((default-directory dir))
      (when (not (file-exists-p "_posts"))
        (error "not a jekyll project"))
      ;;2014-08-27-first-post.markdown
      (let* ((file-name (concat "_posts/" 
                                (format-time-string "%Y-%m-%d-")
                                (replace-regexp-in-string "[^a-zA-Z]" "-" title)
                                ".md"))
             (b (find-file file-name)))
        (with-current-buffer b
          (when (zerop (buffer-size))
            (wcy-jekyll-insert-front-matter title)))))))
;;;###autoload
(defun wcy-jekyll-insert-front-matter (title)
  ""
  (interactive "sTitle: ")
  (insert (format
"---
layout: post
title:  \"%s\"
date:   %s
categories: 
---
" title (format-time-string "%Y/%m/%d %H:%M:%S"))))
