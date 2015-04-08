(defvar wcy-complete-directory "~/.emacs.d/wcy-ac") 
(defvar wcy-complete-history nil)
(defvar wcy-complete-mode-groups
  '((c++-mode c-mode)
    ))

(make-variable-buffer-local 'wcy-complete-history)
;;;###autoload
(defun wcy-complete()
  (interactive)
  (apply #'wcy-complete-execute-ac (wcy-complete-guess-ac)))
(defun wcy-complete-guess-ac ()
  (let* ((ac-defines (wcy-complete-build-defs))
         (abbrevations (mapcar 'car ac-defines))
         (ret-old (cond
                   ((looking-back (regexp-opt abbrevations) (line-beginning-position))
                    (list (match-string 0) (match-beginning 0) (match-end 0)))
                   (t 
                    (let ((bounds (bounds-of-thing-at-point 'symbol)))
                      (when bounds
                        (let* ((input-text (buffer-substring (car bounds) (cdr bounds)))
                               (completions (all-completions input-text abbrevations)))
                          (list (if (= (length completions) 1)
                                    (car completions)
                                  (completing-read "wcy-completion:" 
                                                   abbrevations nil t input-text 

                                                   wcy-complete-history))
                                (car bounds) (cdr bounds)))))))))
    (cons
     (let ((ac (car ret-old)))
       (aif (cdr-safe (assoc ac ac-defines))
           (expand-file-name (concat ac ".ac") it)
         (error "cannot found abbre file  %s " ac)))
     (cdr ret-old))))
(defun wcy-complete-execute-ac (file-name beg end)
  (when (file-readable-p file-name)
    (delete-region beg end)
    (skeleton-insert 
     (with-temp-buffer
       (insert-file-contents file-name)
       (read (current-buffer))))))
(defun wcy-complete-build-defs ()
  (let* ((modes `(,@(mapcar 'symbol-name
                        (or (assoc major-mode wcy-complete-mode-groups)
                            (list major-mode))) "fundamental-mode"))
         (dirs (remove-if-not
                #'(lambda (name)
                    (let* ((basename (file-name-nondirectory name)))
                      (member basename modes)))
                (directory-files wcy-complete-directory t "-mode"))))
    (mapcan
     #'(lambda (directory)
         (mapcar 
          #'(lambda (f) 
              (cons (file-name-sans-extension f) directory))
          (directory-files directory nil "\\.ac$" nil)))
     dirs)))



