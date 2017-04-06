;;;###autoload
(defun wcy-c-open-other-file ()
  "if current file is a header file, then open the
corresponding source file or vice versa.
"
  (interactive)
  (let ((f (buffer-file-name))
        (headers '("h" "hpp" "hxx"))
        (sources '("c" "cxx" "cpp" "cc")))
    (if f
        (let* ((b (file-name-sans-extension f))
               (x (file-name-extension f))
               (s (cond
                   ((member x headers) sources)
                   ((member x sources) headers)
                   (t nil)))
               (return-value nil)
               (cscope.files (wcy-search-file-in-parent-dir '("cscope.files") "." )))
          (if cscope.files
              (wcy-c-open-other-file-cscope.files cscope.files
                                                  (file-name-nondirectory b) s)
            (wcy-c-open-other-file-1 (mapcar #'(lambda (ext) (concat b "." ext)) s)))))))
(defun wcy-c-open-other-file-cscope.files (cscope.files b s)
  (let* ((regexp (mapconcat #'(lambda (x)
                                (concat "/" (regexp-quote (concat b "." x))))
                            s
                           "\\|"))
        (files  (wcy-map-line cscope.files regexp))
        (default-directory (file-name-directory cscope.files)))
    (if files
      (wcy-c-open-other-file-1 files)
      (message "files=%S regexp=%S" files regexp))))
(defun wcy-c-open-other-file-1 (xfiles)
  (let (try-file (files xfiles))
    (unless (catch 'return
              (while  files
                (setq try-file (expand-file-name (car files)))
                (cond
                 ((find-buffer-visiting try-file)
                  (switch-to-buffer (find-buffer-visiting try-file))
                  (throw 'return t))
                 ((file-readable-p try-file)
                  (find-file try-file)
                  (throw 'return t )))
                (setq files (cdr files))))
      (message "wcy-c-open-other-file: no suitable file %s" xfiles))))
(defun wcy-map-line (file-or-buffer regexp)
  (save-excursion
    (with-temp-buffer
      (wcy-map-line-buffer (if (bufferp file-or-buffer) file-or-buffer
                             (progn
                               (insert-file-contents file-or-buffer)
                               (current-buffer)))
                           regexp))))
(defun wcy-map-line-buffer (buffer regexp)
  (let (ret)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward regexp nil t nil)
        (push (buffer-substring (line-beginning-position) (line-end-position)) ret)))
    ret))

(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))

;;;###autoload
(defun wcy-cscope-find-file ()
  (interactive)
  (let* ((cscope.files (wcy-search-file-in-parent-dir '("cscope.files") "." )))
    (if (not cscope.files)
        (error "cannot find cscope.files")
      (let* ((files  (read-lines cscope.files))
             (default-directory (file-name-directory cscope.files))
             (file (ido-completing-read "cscope find file " files)))
        (find-file file)))))


(defun wcy-open-cscope-file ()
  (interactive)
  (let* ((cscope.files (wcy-search-file-in-parent-dir '("cscope.files") "." )))
    (if (not cscope.files)
        (error "cannot find cscope.files")
      (find-file cscope.files))))
