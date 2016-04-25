;; default value for the useful variables
(defvar after-init-time nil)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://stable.melpa.org/packages/") t)
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
;;(require 'cl-extra)
;; (if (not (boundp 'cl-coerce))
;;     (defalias 'cl-coerce 'coerce))
;; this function is used by wcy-update-my.elisp-directory-autoloads
(require 'wcy-compose)
;; -------------------- LOAD PRECOMPILED AUTOLOADS ------------
;; try to load precompiled auto to speed up.
(autoload 'wcy-update-my\.elisp-directory-autoloads "../my.elisp/wcy-update-my.elisp-directory-autoloads" "" nil nil)
(wcy-update-my.elisp-directory-autoloads)
;; --------------------- SETUP MY KEY BINDINGS -----------------
(wcy-global-set-key
 "C-z" 'kmacro-start-macro-or-insert-counter
 "M-z" 'kmacro-end-or-call-macro
 "C-w"  'backward-kill-word
 "M-7" 'compile
 ;;"C-x" #'(lambda () (interactive) (ding))
 ;;"C-v" 'yank
 "<f7>" 'compile
 "M-`" 'next-error
 "<C-s-268632070>"  'toggle-fullscreen
 )
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
(when (display-graphic-p)
  (cond
   ((eq emacs-major-version 23)
    (wcy-eval-if-installed
        "color-theme"
      (require 'color-theme)
      (wcy-eval-if-installed "color-theme-solarized"
        (require 'color-theme-solarized)
        (color-theme-solarized-light))))
   ((or (and (eq emacs-major-version 24)
             (> emacs-minor-version 2))
        (eq emacs-major-version 25))
    (defun plist-to-alist (the-plist)
      (defun get-tuple-from-plist (the-plist)
        (when the-plist
          (cons (car the-plist) (cadr the-plist))))

      (let ((alist '()))
        (while the-plist
          (add-to-list 'alist (get-tuple-from-plist the-plist))
          (setq the-plist (cddr the-plist)))
        alist))
    (wcy-eval-if-installed
        "color-theme"
      (require 'color-theme)
      (wcy-eval-if-installed "color-theme-solarized"
        (require 'color-theme-solarized)
        (color-theme-solarized-light))))))
(set-default 'tab-width 4)
(set-default 'indent-tabs-mode nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace t nil)
(add-to-list 'minor-mode-alist '(mark-active " Mark"))
(defalias 'yes-or-no-p #'y-or-n-p)
(defvar wcy-leader-key-mode t
  "Minor mode to support <leader> support.")
(defun wcy-make-keymap(args)
  (let ((m (make-sparse-keymap)))
    (mapc
     #'(lambda (k-c)
	 (define-key m (read-kbd-macro (car k-c)) (cdr k-c)))
     args)
    m))
(defconst wcy-emulation-mode-map-alist
  `((mark-active
     ,@(wcy-make-keymap
	`(
	  ("a" . move-beginning-of-line)
	  ("A" . beginning-of-defun)
	  ("b" . backward-word)
	  ("B" . backward-sexp)
	  ("c" . kill-ring-save)
	  ("C-d" . (lambda(b e)
		     (interactive "r")
		     (delete-region b e)))
	  ("d" . (lambda(b e)
		   (interactive "r")
		   (delete-region b e)))
	  ("e" . move-end-of-line)
	  ("f" . forward-word)
	  ("F" . forward-sexp)
	  ("n" . next-line)
	  ("o" . exchange-point-and-mark)
	  ("p" . previous-line)
	  ("q" . keyboard-quit)
	  ("u" . backward-up-list)
	  ("C-w" . kill-region)
	  ("w" . kill-region)
	  ("x" . kill-region)
	  ("y" . (lambda(b e)
		   (interactive "r")
		   (delete-region b e)
		   (call-interactively 'yank)))
	  ("v" . (lambda(b e)
		   (interactive "r")
		   (delete-region b e)
		   (call-interactively 'yank)))
	  ("SPC" . (lambda () (interactive "") (set-mark (point))))
	  )))
    (wcy-leader-key-mode
     ,@(wcy-make-keymap
	`(
	  ("\\" ,@(wcy-make-keymap
		    `(
		      ("\\" .
		       (lambda ()
			(interactive)
			(switch-to-buffer (other-buffer))))
		      ("b" . iswitchb-buffer)
		      ("c" . kill-ring-save)
		      ("d" . nil)
		      ("d d" . kill-line)
		      ("f" . nil)
		      ("f s" . save-buffer)
		      ("f o" . find-file-at-point)
		      ("f S" . save-some-buffers)
		      ("(" . insert-parentheses)
		      ("\"" . (lambda (arg) (interactive "P")
				(insert-pair arg ?\" ?\")))
		      ("[" . (lambda (arg) (interactive "P")
			       (insert-pair arg ?\[ ?\])))
		      ("{" . (lambda (arg) (interactive "P")
			       (insert-pair arg ?\{ ?\})))
		      ("g" . nil)
		      ("g g" . beginning-of-buffer)
		      ("g t" . goto-line)
		      ("g w" . ace-jump-word-mode)
		      ("g c" . ace-jump-char-mode)
		      ("g l" . ace-jump-line-mode)
		      ("G"  . end-of-buffer)
		      ("h" . help-command)
		      ("l" . iswitchb-buffer)
		      ("L" . ibuffer)
		      ("n" . universal-argument)
		      ("o" . exchange-point-and-mark)
		      ("r" . query-replace-regexp)
		      ("s" . (lambda () (interactive)
			       (call-interactively 'search-forward)
			       (unless mark-active (set-mark (match-beginning 0)))))
		      ("S" . (lambda () (interactive)
			       (call-interactively 'search-backward)
			       (unless mark-active (set-mark (match-end 0)))))
		      ("p" . nil)
		      ("p b" . compile)
		      ("w" . kill-region)
		      ("@" . mark-sexp)
		      ("x" ,@ctl-x-map)
		      ("y" . yank)
		      ("v" . yank)
		      ("u" . undo)
		      ("SPC" . set-mark-command)
		      (":" . pp-eval-expression)
		      ("/" . dabbrev-expand)
		      ("?" . hippie-expand)
		      ("4" . kill-this-buffer)
		      ("1" . delete-other-windows)
		      ("2" . mark-sexp)
		      ("0" . wcy-other-window)
		      ("5" . wcy-display-buffer-name)
		      ("]" . wcy-complete)
		      ("3" . wcy-toggle-shell-and-cd)
		      ("#" . wcy-toggle-shell)
		      ("`" . next-error)
		      ("!" . shell-command)
		      ("RET" . execute-extended-command)
		      )))
	  )))
    ))
(wcy-adhoc-clipboard-enable)
(add-to-list 'emulation-mode-map-alists
	     'wcy-emulation-mode-map-alist)

;;; --------------------- MY SETTINGS -----------------------
;; do NOT add whitespace as needed when inserting parentheses.
(setq parens-require-spaces nil)
(setq split-width-threshold 2400) ; I prefer split horizontally.
 ;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
;; setup these mode at idle time
(run-with-idle-timer
 1 nil
 #'(lambda ()
     (show-paren-mode 1)
     (iswitchb-mode t)
     (which-func-mode 1)))
(if (eq system-type 'darwin)
    (menu-bar-mode t)
    (menu-bar-mode 0))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1)
    (setq tool-bar-mode nil))
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
;; ------------------- SKELETON ----------------------------
(eval-after-load "skeleton"
  '(progn
     (setq skeleton-end-newline nil)
     (setq skeleton-pair nil)))
;; ------------------- COMPILE ------------------------------
(eval-after-load "compile"
  '(progn
     (setq compilation-scroll-output t
           compilation-read-command nil)
     ))
;; ------------------- C/C++ --------------------------------
(eval-after-load "ffap"
  '(progn
     (if (getenv "INCLUDE")
         (setq ffap-c-path
               (append (split-string (getenv "INCLUDE") ":" nil)
                       ffap-c-path)))))
(eval-after-load "cc-mode"
  '(progn
     (setq gud-chdir-before-run nil)
     ;; 设置缩进风格. 用 M-x c-set-style ,然后用 TAB 查看补全结果,可以看到所有风格名称.
     (setq c-default-style
           '((java-mode . "java")
             ;;(c-mode . "k&r")
             (c-mode . "linux")
             ;;(c++-mode . "ellemtel")
             (c++-mode . "stroustrup")
             (other . "gnu")
             ))
     (add-hook 'c-mode-hook 'wcy-c-mode-hook)
     (add-hook 'c++-mode-hook 'wcy-c-mode-hook)
     (add-hook 'c++-mode-hook 'hs-minor-mode)
     (setq vc-diff-switches "-bBu")
     (setq ffap-c-path '("/usr/include/c++/4.3/" "/usr/include"))
     (define-key c-mode-map (kbd "C-c f") 'wcy-c-open-other-file)
     (define-key c++-mode-map (kbd "C-c f") 'wcy-c-open-other-file)
     ))
(wcy-eval-if-installed "xcscope"
  (progn
    (autoload 'cscope-minor-mode "xcscope")
    (add-hook 'c-mode-hook (function cscope-minor-mode))
    (add-hook 'c++-mode-hook (function cscope-minor-mode))
    (add-hook 'dired-mode-hook (function cscope-minor-mode))
    (add-hook 'cscope-list-entry-hook 'wcy-cscope-list-entry-hook)
     (if (display-graphic-p)
         (setq cscope-use-face t)
       (setq cscope-use-face nil))
     (defun wcy-cscope-list-entry-hook()
       (local-set-key (kbd "<RET>") 'cscope-select-entry-other-window))
     ))
;; ------------------- MARKDOWN -----------------------------
(wcy-eval-if-installed "markdown-mode"
  (autoload 'markdown-mode "markdown-mode")
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  (eval-after-load "markdown-mode"
    '(progn
       (setq markdown-command "multimarkdown")
       (setq markdown-command "markdown")
       (define-key markdown-mode-map (kbd "ESC <up>") 'markdown-move-up)
       (define-key markdown-mode-map (kbd "ESC <down>") 'markdown-move-down)
       (define-key markdown-mode-map (kbd "ESC <left>") 'markdown-promote)
       (define-key markdown-mode-map (kbd "ESC <right>") 'markdown-demote)
       (define-key markdown-mode-map (kbd "<M-RET>") 'markdown-insert-list-item)
       (setq markdown-xhtml-header-content
             "<script type=\"text/x-mathjax-config\">
  MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'],['[',']']]}});
</script>
<script type=\"text/javascript\"
  src=\"http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML\">
</script> ")
       (defun my-markdown-hook()
         (let ((filename (wcy-search-file-in-parent-dir (list "markdown.css")
                                                        default-directory)))
           (setq markdown-css-path
                 (or (and filename
                          (file-relative-name filename default-directory))
                     "")))
         ;; (add-hook 'after-save-hook 'markdown-export t t)
         )
       (add-hook 'markdown-mode-hook 'my-markdown-hook)
       )))
;; -------------------- ELISP --------------------------------
(eval-after-load "lisp-mode"
  '(progn
     (defun wcy-lisp-mode-common-hook()
       (set-fill-column 80)
       (hs-minor-mode 1)
       (local-set-key (kbd "C-c C-v") 'hs-toggle-hiding))
     (defun wcy-emacs-lisp-mode-hook()
       (interactive)
       (wcy-lisp-mode-common-hook)
       ;; compile after file is saved.
       (add-hook 'after-save-hook 'wcy-emacs-lisp-compile-on-save t t))
     (defun wcy-lisp-mode-hook()
       (wcy-lisp-mode-common-hook))
     (defun wcy-emacs-lisp-compile-on-save ()
       (if (and buffer-file-name
                (string-match "\\.el$" buffer-file-name))
           (byte-compile-file buffer-file-name)))
     (add-hook 'lisp-mode-hook 'wcy-lisp-mode-common-hook)
     (add-hook 'emacs-lisp-mode-hook 'wcy-emacs-lisp-mode-hook)
     (add-hook 'emacs-lisp-mode-hook 'auto-fill-mode)
     (define-key emacs-lisp-mode-map (kbd "C-c C-l") 'eval-buffer )
     (define-key emacs-lisp-mode-map (kbd "C-c C-c") 'eval-defun )
     (define-key emacs-lisp-mode-map (kbd "C-c C-m") 'pp-macroexpand-expression )
     ;;(define-key emacs-lisp-mode-map (kbd "<SPC>") 'just-one-space)
     ))
;; ------------------- protobuf ------------------------
(wcy-eval-if-installed "protobuf-mode"
  (require 'protobuf-mode)
  (add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode)))
;; ------------------- ERLANG --------------------------
;; detect erlang installation.
(let* ((erl-exec (locate-file "escript" exec-path)))
  (when erl-exec
    (let ((temp-file (make-temp-file "erl")))
      (with-temp-file temp-file
        (insert "#!/usr/bin/env escript
-export([main/1]).
main(_) ->
    ToolPath = code:lib_dir(tools),
    RootDir = code:root_dir(),
    io:format(\"(setq erlang-root-dir ~p)~n\",[RootDir]),
    ElangModePath = filename:join(ToolPath, \"emacs\"),
    io:format(\"(add-to-list 'load-path ~p)~n\",[ElangModePath]).
"))
      (with-temp-buffer
        (call-process-shell-command "escript"
                                    nil ;input
                                    (current-buffer) ;output
                                    nil      ;display
                                    temp-file)
        (message "%s" (buffer-string))
        (delete-file temp-file)
        (eval-buffer)
        ))))
(wcy-eval-if-installed "erlang"
  (require 'erlang)
  ;;  this is set properly in the detection period
  ;; (setq erlang-root-dir  "/home2/chunywan/d/local/lib/erlang")
  (setq inferior-erlang-machine-options
        (list "-sname"
              (format "%s" (emacs-pid))
              "-remsh"
              ;;"ejabberd@localhost"
              ;;"tsung_controller@my"
              ;;"msync2@localhost"
              ;;"message@localhost"
              ;; msync_client@localhost
              ;;"message@localhost"
              ;;"ejabberd@wangchunye"
              "msync@localhost"
              "-hidden"
              ))
  (setenv "ERL_ROOT" erlang-root-dir)
  (setq user-mail-address (or (getenv "EMAIL") ""))
  (setq erlang-skel-mail-address user-mail-address)
  (setq erlang-compile-extra-opts
        (list '(i . "./include")
              'export_all
              (cons 'i (expand-file-name
                        (getenv "HOME")))
              (cons 'i (expand-file-name
                        "d/working/ejabberd/deps/p1_xml/include"
                        (getenv "HOME")))
              (cons 'i (expand-file-name
                        "d/working/msync/include"
                        (getenv "HOME")))
              (cons 'i (expand-file-name
                        "d/working/msync/deps/im_libs/apps/msync_proto/include"
                        (getenv "HOME")))
              (cons 'i (expand-file-name
                        "d/working/easemob/msync/deps/mochiweb/include"
                        (getenv "HOME")))
              (cons 'i (expand-file-name
                        "d/working/wiki.im.hexo/source/asn1-vs-protobuf/index/deps/gpb/include"
                        (getenv "HOME")))
              (cons 'i (expand-file-name
                        "d/working/easemob/deps/tick"
                        (getenv "HOME")))
              (cons 'd (intern "'LAGER'"))
              (cons 'd (intern "'LICENSE'"))
              (list 'd (intern "'INITIAL_LICENSE_TIME'") 86400)
              'debug_info))
  ;; TODO: this is no good way to detect distel is installed.
  (let ((distel-root (expand-file-name "~/d/working/distel")))
    (when (file-exists-p distel-root)
      (let ((dist-el (expand-file-name "elisp" distel-root)))
        (add-to-list 'load-path dist-el)
        (require 'distel)
        (distel-setup)
        (defconst distel-shell-keys
          '(("M-i" erl-complete)
            ("M-?" erl-complete)
            ("M-." erl-find-source-under-point)
            ("M-," erl-find-source-unwind)
            ("M-*" erl-find-source-unwind)
            )
          "Additional keys to bind when in Erlang shell.")
        (defun erlang-shell-mode-hook-1 ()
          ;; add some Distel bindings to the Erlang shell
          (define-key erlang-mode-map (kbd "<f7>") #'erlang-compile)
          (dolist (spec distel-shell-keys)
            (define-key erlang-shell-mode-map (read-kbd-macro (car spec)) (cadr spec))))
        (add-hook 'erlang-shell-mode-hook 'erlang-shell-mode-hook-1)))))

;;; -------------------- GO --------------------
(defvar my-gopath (or (getenv "GOPATH")
                      (getenv "HOME")))
(add-to-list 'load-path (expand-file-name "src/github.com/dougm/goflymake/"
                                          my-gopath))

(wcy-eval-if-installed "go-mode"
  (require 'go-mode-autoloads)
  ;; gotfmt will check whether the major mode is go-mode or not.
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq gofmt-command "goimports")
  (eval-after-load "go-mode"
    '(progn
       (define-key go-mode-map (kbd "M-.") 'godef-jump)
       ;; go get -u github.com/dougm/goflymake1
       ;;  it is buggy
       ;; (wcy-eval-if-installed "flymake"
       ;;   (wcy-eval-if-installed "go-flymake"
       ;;     (require 'go-flymake)))
       (wcy-eval-if-installed "flycheck"
         (wcy-eval-if-installed "go-flycheck"
           (require 'go-flycheck)))
       (defun go-mode-setup ()
         (setq compile-command "go build -v && go test -v && go vet")
         (define-key (current-local-map)
           "\C-c\C-c" 'compile))
       (add-hook 'go-mode-hook 'go-mode-setup)
       ;; package-install company
       (wcy-eval-if-installed "company"
         (wcy-eval-if-installed "company-go"
           (require 'company)
           (require 'company-go)
           ;; bigger popup window
           (setq company-tooltip-limit 20)
           ;; decrease delay before autocompletion
           ;; popup shows
           (setq company-idle-delay .3)
           ;; remove  annoying blinking
           (setq company-echo-delay 0)
           ;; start autocompletion only after typing
           (setq company-begin-commands '(self-insert-command))
           (add-hook 'go-mode-hook 'wcy-go-mode-hook-company)
           (defun wcy-go-mode-hook-company ()
             (set
              (make-local-variable 'company-backends) '(company-go))
             (company-mode))
           ))
       ;; package-install go-eldoc
       (wcy-eval-if-installed "go-eldoc"
         (add-hook 'go-mode-hook 'go-eldoc-setup))
       ;; error check
       ;; go get -u github.com/kisielk/errcheck
       (wcy-eval-if-installed "go-errcheck"
         (require 'go-errcheck)
         (add-hook 'go-mode-hook 'wcy-go-mode-hook-errcheck)
         (defun wcy-go-mode-hook-errcheck ()
           (add-hook 'after-save-hook #'(lambda() (call-interactively
                                                   'go-errcheck)) t t)))
       ;; go get golang.org/x/tools/cmd/oracle
       ;; go get github.com/tleyden/checkers-bot-minimax
       (load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")
       )))
;;; -------------------  DONE --------------------------------
;; setq inhibit-startup-message to show "*scratch*" as the initial
(setq inhibit-startup-message t)
(wcy-dot-emacs-is-done)
(message "dot emacs is successful loaded.")

(defalias 'exit 'save-buffers-kill-terminal)
;; Local Variables:
;; mode:emacs-lisp
;; coding: undecided-unix
;; End:
