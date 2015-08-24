;; to enable the adhoc clipboard
;; M-x wcy-adhoc-clipboard-enable
;; to disable it
;; M-x wcy-adhoc-clipboard-disable


;;;###autoload
(defvar  wcy-adhoc-clipboard-file-name "~/tmp/__emacs_adhoc_clipboard.txt"
  "adhoc clipboard's content is stored in this file")
;;;###autoload
(defun  wcy-adhoc-clipboard-cut (start end)
  "cut text to the adhoc clipboard"
  (interactive "r")
  (wcy-adhoc-clipboard-save-content
   (delete-and-extract-region start end)))
;;;###autoload
(defun  wcy-adhoc-clipboard-copy (start end)
  "copy text to the adhoc clipboard"
  (interactive "r")
  (wcy-adhoc-clipboard-save-content
   (buffer-substring start end)))
;;;###autoload
(defun  wcy-adhoc-clipboard-paste (&optional arg)
  "paste text to the adhoc clipboard"
  (interactive "p")
  (let ((text (wcy-adhoc-clipboard-content)))
    (dotimes (_ arg)
      (insert text))))

;;; helper functions

(defvar wcy-adhoc-clipboard-paste-md5 "")
(defun wcy-adhoc-clipboard-content ()
  (with-temp-buffer
    (insert-file-contents wcy-adhoc-clipboard-file-name)
    (buffer-string)))
(defun wcy-adhoc-clipboard-save-content (text)
  (with-temp-file wcy-adhoc-clipboard-file-name
    (insert text)))
;; Return the value of the current wcy adhoc clipboard
;; If this function is called twice and finds the same text,
;; it returns nil the second time.  This is so that a single
;; selection won't be added to the kill ring over and over.
;;;###autoload
(defun wcy-adhoc-clipboard-get ()
  (let* ((content (wcy-adhoc-clipboard-content))
         (current-md5 (md5 content)))
    (if (string= wcy-adhoc-clipboard-paste-md5 current-md5)
        nil ;; return nil if it is called twice
      (setq wcy-adhoc-clipboard-paste-md5 current-md5)
      content)))
;;;###autoload
(defun wcy-adhoc-clipboard-save (text &optional push)
  (wcy-adhoc-clipboard-save-content text))

(require 'simple)
(defvar wcy-adhoc-clipboard-old-interprogram-functions
  (cons interprogram-paste-function interprogram-cut-function))
(defvar wcy-adhoc-orig-interprogram-paste-function
  interprogram-paste-function)
(defvar wcy-adhoc-orig-interprogram-cut-function
  interprogram-cut-function)

;;;###autoload
(defun wcy-adhoc-clipboard-enable ()
  (interactive)
  (setq wcy-adhoc-orig-interprogram-paste-function
        interprogram-paste-function
        wcy-adhoc-orig-interprogram-cut-function
        interprogram-cut-function)
  (setq interprogram-paste-function
	#'(lambda (&rest args)
	    (let ((x (apply wcy-adhoc-orig-interprogram-paste-function args)))
	      (if x x
		(apply 'wcy-adhoc-clipboard-get args)))))
  (setq interprogram-cut-function
	#'(lambda (&rest args)
	    (apply 'wcy-adhoc-clipboard-save args)
	    (apply wcy-adhoc-orig-interprogram-cut-function args))))

(defun wcy-adhoc-clipboard-disable ()
  (interactive)
  (setq interprogram-paste-function
	wcy-adhoc-orig-interprogram-paste-function
	interprogram-cut-function
	wcy-adhoc-orig-interprogram-cut-function))

;; (cond
;;  ((string= system-type "darwin")
;;   (defun wcy-get-clipboard ()
;;     (shell-command-to-string "pbpaste"))
;;   (defun wcy-set-clipboard (text)
;;     (let ((process-connection-type nil))
;;       (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
;;         (process-send-string proc text)
;;         (process-send-eof proc)))))
;;  (t
;;   (defun wcy-get-clipboard ()

;;   (defun wcy-set-clipboard (text)
;;     (apply 'x-select-text text))


(provide 'wcy-adhoc-clipboard)
;; Local Variables:
;; mode:emacs-lisp
;; coding: utf-8-unix
;; End:
