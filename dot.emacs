(condition-case nil
    (load-file (concat (file-name-as-directory
                        user-emacs-directory) (concat system-name ".el")))
  (error nil))
(setq package-check-signature nil)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
(setq package-enable-at-startup nil)
(when (file-exists-p "/group/dphi_arch/mirrors/elpa-mirror/gnu")
  (setq package-archives '(("gnu"   .  "http://elpa.gnu.org/packages/")
                           ("melpa"
                            .  "http://melpa.org/packages/"))))
(when (not (file-exists-p "/group/dphi_arch/mirrors/elpa-mirror/gnu"))
  (setq package-archives '(("gnu"   . "http://elpa.gnu.org/packages/")
                           ("melpa" . "http://melpa.org/packages/"))))
;; (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(or (package-installed-p 'diminish)
    (package-install 'diminish))
(require 'diminish)
(or (package-installed-p 'bind-key)
    (package-install 'bind-key))
(require 'bind-key)


;; (when (display-graphic-p)
;;   (setq fonts
;;         (cond ((eq system-type 'darwin)     '("Andale Mono"     "STHeiti"))
;;               ((eq system-type 'gnu/linux)  '("Menlo"     "WenQuanYi Zen Hei"))
;;               ((eq system-type 'windows-nt) '("Consolas"  "Microsoft Yahei"))))

;;   (setq face-font-rescale-alist '(("STHeiti" . 1.2) ("Microsoft Yahei" . 1.2) ("WenQuanYi Zen Hei" . 1.2)))
;;   (set-face-attribute 'default nil :font
;;                       (format "%s:pixelsize=%d" (car fonts) 14))
;;   (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;     (set-fontset-font (frame-parameter nil 'font) charset
;;                       (font-spec :family (car (cdr fonts))))))


(setenv "MY_EMACS_HOME" (or (getenv "MY_EMACS_HOME")
                            (concat (getenv "HOME")  "/d/working/wcy_dot_emacs")))
(load (expand-file-name
       "dot.emacs"
       (concat (getenv "MY_EMACS_HOME") "/my.config")))
(add-to-list 'load-path (concat (getenv "MY_EMACS_HOME") "/my.config"))
;;(require 'dot-emacs)
(put 'narrow-to-region 'disabled nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (markdown-mode find-file-in-project rg racer rust exec-path-from-shell rust-mode proj projectile ggtags haskell-mode company-irony-c-headers protobuf-mode paredit cmake-mode xcscope avy ace-jump-mode flycheck company-c-headers company-irony company ivy clang-format irony diminish use-package)))
 '(query-replace-from-to-separator " -> ")
 '(safe-local-variable-values (quote ((a 1972))))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Local Variables:
;; mode:emacs-lisp
;; coding: undecided-unix
;; End:
(set-default 'cursor-type 'box)
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
