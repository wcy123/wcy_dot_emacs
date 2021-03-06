;; default value for the useful variables
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (or (memq window-system '(mac ns x))
            (memq system-type '(darwin)))
    (exec-path-from-shell-initialize)))
;; == irony-mode ==
(use-package irony
  :ensure t
  :after cc-mode
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  ;; replace the `completion-at-point' and `complete-symbol' bindings in
  ;; irony-mode's buffers by irony-mode's function
  (defun my-irony-mode-hook ()
    (set (make-local-variable 'company-backends)
         '(company-irony-c-headers company-irony company-gtags))
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
  (setq irony-additional-clang-options '("-std=c++11"))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  (use-package company-irony-c-headers
    :ensure t
    )
  )

(use-package projectile
  :ensure
  :config
  (setq projectile-completion-system 'ivy)
  (setq a 1))

(use-package clang-format
  :ensure t
  :config
  (set-default 'clang-format-fallback-style "Google")
  (add-hook 'c-mode-common-hook
            #'(lambda ()
                (local-set-key
                 (kbd "TAB")
                 #'(lambda ()
                     (interactive)
                     (call-interactively 'back-to-indentation)
                     (call-interactively 'clang-format-region))))))

(use-package ivy
  :ensure t
  :config
  (ivy-mode t)
  (setq ivy-use-virtual-buffers t))
;; == company-mode ==
(use-package company
  :ensure t
  :defer t
  :init (add-hook 'after-init-hook 'global-company-mode)
  :bind (:map company-active-map
              (("C-n" . company-select-next)
               ("C-p" . company-select-previous)))
  :config
  (setq company-idle-delay              nil
        company-minimum-prefix-length   2
        company-show-numbers            t
        company-tooltip-limit           20
        company-dabbrev-downcase        nil
        )
  :bind ("M-RET" . company-complete-common)
  )
(use-package company-irony
  :after company
  :ensure t
  :defer t)
(use-package company-c-headers
  :ensure t
  :after company
  :defer t)

;; == flycheck ==
(use-package flycheck
  :ensure t
  :defer t
  :config
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'c-mode-hook 'flycheck-mode))

(when (>= emacs-major-version 25)
  ;; (use-package ggtags
  ;;   :ensure nil
  ;;   :defer t
  ;;   :init
  ;;   (add-hook 'c-mode-common-hook
  ;;             (lambda ()
  ;;               (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
  ;;                 (ggtags-mode 1))))
  ;;   :config
  ;;   (define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
  ;;   (define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
  ;;   (define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
  ;;   (define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
  ;;   (define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
  ;;   (define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)
  ;;   (define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)
  ;;   )
  )
(use-package ace-jump-mode
  :ensure t)
;; == my personal setup ==
(defvar after-init-time nil)
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
(use-package recentf
  :defer t
  :config
  (setq recentf-max-saved-items 200))

(wcy-global-set-key
 "C-z" 'kmacro-start-macro-or-insert-counter
 "M-z" 'kmacro-end-or-call-macro
 "C-w"  'backward-kill-word
 "M-7" 'compile
 "M-2" 'compile
 ;;"C-x" #'(lambda () (interactive) (ding))
 ;;"C-v" 'yank
 "<f7>" 'compile
 "M-`" 'next-error
 "M-1" 'next-error
 "<f3>" 'next-error
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
;; (defvar wcy-leader-key-mode t
;;   "Minor mode to support <leader> support.")
(defun wcy-make-keymap(args)
  (let ((m (make-sparse-keymap)))
    (mapc
     #'(lambda (k-c)
	 (define-key m (read-kbd-macro (car k-c)) (cdr k-c)))
     args)
    m))
(use-package leader-key-mode
  :load-path "~/d/working/leader-key-mode"
  :config
  (define-key leader-key-mode-keymap (kbd "p") projectile-command-map)
  (defun my-delete-region (b e)
    (interactive "r")
    (delete-region b e))
  )
(use-package avy
  :ensure t
  :commands
  ( avy-goto-char
    avy-goto-char-2
    avy-isearch
    avy-goto-line
    avy-goto-subword-0
    avy-goto-subword-1
    avy-goto-word-0
    avy-goto-word-1
    avy-copy-line
    avy-copy-region
    avy-move-line
    avy-move-region
    avy-kill-whole-line
    avy-kill-region
    avy-kill-ring-save-whole-line
    avy-kill-ring-save-region)
  :config

  (wcy-adhoc-clipboard-enable))
(eval-after-load "isearch"
  '(progn
     (load-file (locate-file "avy-autoloads.el" load-path))
     (define-key isearch-mode-map (kbd "C-l") 'avy-isearch)
     (add-hook 'isearch-mode-end-hook 'my-goto-match-beginning)
     ;;(remove-hook 'isearch-mode-end-hook 'my-goto-match-beginning)
     (defun my-goto-match-beginning ()
       (when (and isearch-forward isearch-other-end
                  (not
                   ;; conflict with avy-isearch
                   (eq this-command 'avy-isearch)))
        (goto-char isearch-other-end)))))

(use-package rg
  :ensure t
  :commands
  (rg
   )
  :bind (:map global-map ("C-c s"  . rg))
  :config
  (define-key leader-key-mode-keymap (kbd "s") rg-global-map)
  )
;; (add-to-list 'emulation-mode-map-alists
;; 	     'wcy-emulation-mode-map-alist)

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
;; (run-with-idle-timer
;;  1 nil
;;  #'(lambda ()
;;      (show-paren-mode 1)
;;      (setq ido-use-virtual-buffers t)
;;      (setq ido-everywhere t)
;;      (setq ido-enable-flex-matching t)
;;      (ido-mode 1)
;;      (global-subword-mode t)
;;      (which-func-mode 1)))
(show-paren-mode)
(global-subword-mode t)
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
 ;; (wcy-eval-if-installed
 ;;     "session"
 ;;   (require 'session)
 ;;   (add-hook 'after-init-hook 'session-initialize)
;;   (setq session-initialize '(session)))
;; (desktop-save-mode 1)
(savehist-mode t)
;; ------------------- SKELETON ----------------------------
(eval-after-load "skeleton"
  '(progn
     ))
(use-package skeleton
  :defer t
  :init
  (setq skeleton-end-newline nil)
  (setq skeleton-pair nil))
;; ------------------- COMPILE ------------------------------
(use-package compile
  :config
  (setq compilation-scroll-output t
        compilation-read-command nil))
;; ------------------- C/C++ --------------------------------
(use-package ffap
  :config
  (if (getenv "INCLUDE")
      (setq ffap-c-path
            (append (split-string (getenv "INCLUDE") ":" nil)
                    ffap-c-path))))
(use-package cc-mode
  :defer t
  :config
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
  (add-hook 'c-mode-common-hook 'google-set-c-style)
  (add-hook 'c-mode-common-hook 'google-make-newline-indent)
  (setq vc-diff-switches "-bBu")
  (setq ffap-c-path '("/usr/include/c++/4.3/" "/usr/include"))
  (define-key c-mode-map (kbd "C-c f") 'wcy-c-open-other-file)
  (define-key c++-mode-map (kbd "C-c f") 'wcy-c-open-other-file))
;; wired xcsope is not work well with use package
(or (package-installed-p 'xcscope)
    (package-install 'xcscope))
(use-package xcscope
  :after cc-mode
  :config
  (autoload 'cscope-minor-mode "xcscope")
  (add-hook 'c-mode-hook (function cscope-minor-mode))
  (add-hook 'c++-mode-hook (function cscope-minor-mode))
  (add-hook 'dired-mode-hook (function cscope-minor-mode))
  (add-hook 'cscope-list-entry-hook 'wcy-cscope-list-entry-hook)
  (if (display-graphic-p)
      (setq cscope-use-face t)
    (setq cscope-use-face t))
  (defun wcy-cscope-list-entry-hook()
    (local-set-key (kbd "<RET>") 'cscope-select-entry-other-window)))
(use-package cmake-mode
  :ensure t
  :mode "CMakeLists\\.txt\\'"
  :mode "\\.cmake\\'"
  :config
  (defun my-cmake-mode-hook ()
    (set (make-local-variable 'company-backends) '(company-files company-cmake)))
  (add-hook 'cmake-mode-hook 'my-cmake-mode-hook))
;; ------------------- MARKDOWN -----------------------------
(use-package markdown-mode
  :ensure t
  :mode "\\.md\\'"
  :mode "\\.markdown\\'"
  :config
  (setq markdown-command "multimarkdown"
        markdown-command "markdown"
        markdown-xhtml-header-content
        "<script type=\"text/x-mathjax-config\">
  MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'],['[',']']]}});
</script>
<script type=\"text/javascript\"
  src=\"http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML\">
</script> ")
  :bind (:map markdown-mode-map
              ("ESC <up>"  . markdown-move-up)
              ("ESC <down>" . markdown-move-down)
              ("ESC <left>" . markdown-promote)
              ("ESC <right>" . markdown-demote)
              ("C-j" . tmux-cc-send-current-line)
              ("C-M-j" . tmux-cc-select-block)
              ("C-c <RET>" . tmux-cc-send-region)
              ("<M-RET>" . markdown-insert-list-item))
  :config
  (defun my-markdown-hook()
    (let ((filename (wcy-search-file-in-parent-dir (list "markdown.css")
                                                   default-directory)))
      (setq markdown-css-path
            (or (and filename
                     (file-relative-name filename default-directory))
                "")))
    ;; (add-hook 'after-save-hook 'markdown-export t t)
    )
  (require 'tmux-cc)
  (add-hook 'markdown-mode-hook 'my-markdown-hook))
;; -------------------- ELISP --------------------------------
(use-package lisp-mode
  :defer t
  :config
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
  ;; (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  :bind (:map emacs-lisp-mode-map
              ("C-c C-l" . eval-buffer)
              ("C-c C-c" . eval-defun)
              ("C-c C-m" . pp-macroexpand-expression)
              ;;("<SPC>" . just-one-space
              ))
;; ------- pareedit
(use-package paredit
  :if (>= emacs-major-version 25)
  :ensure t
  :commands enable-paredit-mode
  :config
  (define-key paredit-mode-map (kbd "ESC <right>")
    #'paredit-forward-slurp-sexp)
  (define-key paredit-mode-map (kbd "ESC <left>")
    #'paredit-forward-barf-sexp)
  (define-key paredit-mode-map (kbd "M-9")
    #'paredit-backward-slurp-sexp)
  (define-key paredit-mode-map (kbd "M-0")
    #'paredit-backward-barf-sexp))
;; ----------- SCHEME ---------
(use-package scheme
  :ensure t
  :defer t
  :config
  (add-hook 'scheme-mode-hook 'enable-paredit-mode))
;; ------------------- protobuf ------------------------
(use-package protobuf-mode
  :ensure t
  :mode "\\.proto\\'")
;; ------------------- ERLANG --------------------------
(use-package erlang
  :mode ("\\.erl" . erlang-mode)
  :config
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
              ;; "etcd@localhost"
              ;;"ejabberd@wangchunye"
              ;; "xmpp@localhost"
              ;;"xmpp@localhost"
              "hisiwww@dg17"
              "-hidden"
              ))
  (setenv "ERL_ROOT" erlang-root-dir)
  (setq user-mail-address (or (getenv "EMAIL") ""))
  (setq erlang-skel-mail-address user-mail-address)
  (setq erlang-compile-extra-opts
        (list '(i . "./include")
              'export_all
              (cons 'i
                    "/usr/local/Cellar/erlang/18.2.1/lib/erlang/lib/kernel-4.1.1/src")
              (cons 'i "/usr/local/Cellar/erlang/18.2.1/lib/erlang/lib/kernel-4.1.1/include")
              (cons 'i (expand-file-name
                        "d/working/msync/deps/lager/include"
                        (getenv "HOME")))
              (cons 'i (expand-file-name
                        "d/working/msync/deps/im_libs/apps/message_store/include"
                        (getenv "HOME")))
              (cons 'i (expand-file-name
                        "d/working/msync/deps"
                        (getenv "HOME")))
              (cons 'i (expand-file-name
                        (getenv "HOME")))
              (cons 'i (expand-file-name
                        "d/working/ejabberd/deps/p1_xml/include"
                        (getenv "HOME")))
              (cons 'i (expand-file-name
                        "d/working/ejabberd/deps/eredis/include"
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
                        "d/working/ejabberd/include"
                        (getenv "HOME")))
              (cons 'i (expand-file-name
                        "d/working/easemob/deps/tick"
                        (getenv "HOME")))
              (cons 'd (intern "'LAGER'"))
              (cons 'd (intern "'TEST'"))
              ;;(cons 'd (intern "'LICENSE'"))
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
(use-package adoc-mode
  :mode "\\.adoc\\'")
;;; -------------------- haskell ---------------
(use-package haskell-mode
  :mode "\\.hs\\'"
  :ensure t)

;;; -------------------- GO --------------------
(defvar my-gopath (or (getenv "GOPATH")
                      (getenv "HOME")))
(add-to-list 'load-path (expand-file-name "src/github.com/dougm/goflymake/"
                                          my-gopath))

(use-package go-mode
  :mode "\\.go\\'"
  :config
  ;; gotfmt will check whether the major mode is go-mode or not.
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq gofmt-command "goimports")
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
  )

;;; ------------------ for rust ----------------------------
(use-package rust-mode
  :mode "\\.rs\\'"
  :ensure t
  :config
  (add-hook 'rust-mode-hook #'cargo-minor-mode)
  (setq rust-format-on-save t))
(use-package racer
  :ensure t
  :config
  :after (rust-mode)
  :config
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode)
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t)
  (setq racer-loaded 1))


;;; ------------------ for bazel -----------------------------
(add-to-list 'auto-mode-alist '("\\.bzl\\'" . python-mode))
(add-to-list 'auto-mode-alist '("WORKSPACE" . python-mode))

;;; -------------------  DONE --------------------------------
;; setq inhibit-startup-message to show "*scratch*" as the initial
(setq inhibit-startup-message t)
(wcy-dot-emacs-is-done)
(message "dot emacs is successful loaded.")
;; if behind a proxy, use this method
;; (setq url-gateway-method 'socks)
;; (setq socks-server '("Default server" "127.0.0.1" 10080 5))
(defalias 'exit 'save-buffers-kill-terminal)
;; Local Variables:
;; mode:emacs-lisp
;; coding: undecided-unix
;; End:
