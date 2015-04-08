;; default value for the useful variables
(defvar my-emacs-home 
  (if load-file-name
      (file-name-as-directory (expand-file-name ".." (file-name-directory load-file-name)))
    (or (getenv "MY_EMACS_HOME") "~/MyEmacs")))
(defvar my-elisp-path (expand-file-name "my.elisp" my-emacs-home))
(defvar my-config-path (expand-file-name "my.config" my-emacs-home))
(defvar my-data-path (expand-file-name "my.data" my-emacs-home))

;; ------------------- MEASURE --------------------------------
;; measure the loading time per file.
(defvar wcy-profile-startup '())
(defadvice load (around load-with-time-logging)
  "display the load time for each file."
  (let ((now (float-time)))
    ad-do-it
    (push (cons file (- (float-time) now)) wcy-profile-startup)))
(ad-activate 'load)
;; -------------------- PATH ----------------------------------
(add-to-list 'load-path my-elisp-path)
(add-to-list 'load-path (expand-file-name "my.package" my-emacs-home))
;; -------------------- LOAD MOST COMMON MODULE ---------------
;; remove-if-not is defined here
(require 'cl)
;; this function is used by wcy-update-my.elisp-directory-autoloads
(require 'wcy-compose)
;; -------------------- LOAD PRECOMPILED AUTOLOADS ------------
;; try to load precompiled auto to speed up.
(autoload 'wcy-update-my\.elisp-directory-autoloads "../my.elisp/wcy-update-my.elisp-directory-autoloads" "" nil nil)
(wcy-update-my.elisp-directory-autoloads)
;; --------------------- SETUP MY KEY BINDINGS -----------------
(wcy-global-set-key
 "C-x M-e" 'pp-eval-last-sexp
 "C-M-:" 'pp-eval-expression
 "C-/" 'dabbrev-expand
 "M-?" 'dabbrev-expand
 "M-/" 'hippie-expand
 "M-'" 'backward-kill-sexp
 "C-x f" 'find-file-at-point
 "M-<SPC>" 'just-one-space
 "M-4" 'kill-this-buffer
 "M-1" 'delete-other-windows
 "M-0" 'wcy-other-window
 "M-5" 'wcy-display-buffer-name
 "C-]" 'wcy-complete
 "M-3" 'wcy-toggle-shell-and-cd
 "M-#" 'wcy-toggle-shell
 "<f7>" 'compile
 "C-x r C-j" 'wcy-jump-to-register-and-insert
 "M-o" nil
 "M-c" nil
 "M-c M-c" 'capitalize-word
 "M-c M-l" 'downcase-word
 "M-c M-u" 'upcase-word
 "C-x C-c" 'wcy-kill-emacs
 "M-`" 'next-error
 "C-z" 'kmacro-start-macro-or-insert-counter
 "M-z" 'kmacro-end-or-call-macro
 )
(wcy-define-key-in-transient-mode t "\C-w"
                                  'kill-region
                                  'backward-kill-word)
(wcy-define-key-in-transient-mode t (kbd "C-d")
                                  #'(lambda(b e)
                                      (interactive "r")
                                      (delete-region b e))
                                  'delete-char)
;; ---------------------- ACE JUMP --------------------------
(wcy-eval-if-installed "ace-jump-mode"
  (autoload 'ace-jump-mode "ace-jump-mode" "Emacs quick move minor mode" t)
  (global-set-key (kbd "M-l") 'ace-jump-mode))

;;; --------------------- MY SETTINGS -----------------------
;; do NOT add whitespace as needed when inserting parentheses.
(setq parens-require-spaces nil)
(menu-bar-mode 0)
(tool-bar-mode 0)
;;; --------------------- WCY COMPLETE -----------------------
;; for code snippet
(setq wcy-complete-directory (expand-file-name "wcy-ac/" my-data-path))
(global-set-key (kbd "C-]") 'wcy-complete)
;;;---------------------- DESKTOP&SESSION--------------------
;; save all history
(wcy-eval-if-installed  
    "session"
  (require 'session)
  (add-hook 'after-init-hook 'session-initialize)
  (setq session-initialize '(session)))
;; ----------------------- SWITCH BUFFER --------------------
(require 'iswitchb)
(iswitchb-mode t)
;; ------------------- COMPILE ----------------------------
(eval-after-load "compile"
  '(progn 
     (setq compilation-scroll-output t
           compilation-read-command nil) 
     ))
;;; -------------------  DONE --------------------------------
;; setq inhibit-startup-message to show "*scratch*" as the initial
(setq inhibit-startup-message t)
(wcy-dot-emacs-is-done)
(message "dot emacs is successful loaded.")


;; Local Variables:
;; mode:emacs-lisp
;; coding: undecided-unix
;; End:
