;;;###autoload
(defun wcy-c-mode-hook ()
  (setq c-basic-offset 2)
  ;; prevent extern "C" { indenting
  (c-set-offset 'inextern-lang 0)
  (set (make-local-variable 'parens-require-spaces) nil)
  (add-hook 'before-save-hook 'clang-format-buffer t t)
  ;; (add-hook 'before-save-hook 'wcy-maybe-copyright-update t t)
  )

(defun wcy-maybe-copyright-update ()
  (require 'copyright)
  (let ((license-file (wcy-search-file-in-parent-dir '("LICENSE") "." )))
    (when license-file
      (let ((license (with-temp-buffer (insert-file-contents license-file)
                                       (buffer-string))))
        (save-excursion
          (unless (copyright-find-copyright)
            (goto-char 1)
            (insert "/*")
            (setq license-begin (point))
            (insert "\n")
            (insert license)
            (setq license-end (point))
            (insert "\n")
            (replace-string "\n" "\n-- " nil license-begin license-end nil)
            (insert "*/\n")
            (delete-trailing-whitespace)
            ))))))
