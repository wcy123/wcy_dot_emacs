;;;###autoload
(defun wcy-search-file-in-parent-dir (file-list dir &optional pred)
  ""
  (let ((dir-list (wcy-sfipd--expand-dir dir)))
    (catch 'throw 
      (dolist (f file-list)
        (let ((found (locate-file f dir-list nil pred)))
          (when found
            (throw 'throw found)))))))
;;; interal functions
(defun wcy-sfipd--expand-dir (dir &optional result)
  "expand the dir to a list including all his parent directory"
  (if (wcy-sfipd--root-dir-p dir)
      (reverse (cons (expand-file-name dir) result))
    (wcy-sfipd--expand-dir 
     (expand-file-name ".." dir)
     (cons (expand-file-name dir) result))))
(defun wcy-sfipd--root-dir-p (dir)
  (or
   ;; windows root dir for a driver or Unix root
   (string-match "\\`\\([a-zA-Z]:\\)?/$" dir) 
   ;; tramp root-dir
   (and (featurep 'tramp)
        (string-match (concat tramp-file-name-regexp ".*:/$") dir))))

