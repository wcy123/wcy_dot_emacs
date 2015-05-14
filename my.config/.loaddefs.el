;;; .loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (wcy-add-local-variable-for-file) "wcy-add-local-variable-for-file"
;;;;;;  "../my.elisp/wcy-add-local-variable-for-file.el" (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-add-local-variable-for-file.el

(autoload 'wcy-add-local-variable-for-file "wcy-add-local-variable-for-file" "\
Not documented

\(fn)" t nil)

;;;***

;;;### (autoloads (wcy-c-mode-hook) "wcy-c-mode-hook" "../my.elisp/wcy-c-mode-hook.el"
;;;;;;  (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-c-mode-hook.el

(autoload 'wcy-c-mode-hook "wcy-c-mode-hook" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (wcy-complete) "wcy-complete" "../my.elisp/wcy-complete.el"
;;;;;;  (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-complete.el

(autoload 'wcy-complete "wcy-complete" "\
Not documented

\(fn)" t nil)

;;;***

;;;### (autoloads (call aprogn aand awhile awhen aif wcy-find-if
;;;;;;  wcy-map-r wcy-flip wcy-partial-apply* wcy-partial-apply wcy-compose)
;;;;;;  "wcy-compose" "../my.elisp/wcy-compose.el" (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-compose.el

(autoload 'wcy-compose "wcy-compose" "\
Not documented

\(fn &rest FSV)" nil (quote macro))

(autoload 'wcy-partial-apply "wcy-compose" "\
partialy apply the function and return a new function with
fewer arguments

\(fn F &rest ARGS)" nil (quote macro))

(autoload 'wcy-partial-apply* "wcy-compose" "\
partialy apply the function and return a new function with
fewer arguments

\(fn F &rest ARGS)" nil (quote macro))

(autoload 'wcy-flip "wcy-compose" "\
Not documented

\(fn F)" nil (quote macro))

(autoload 'wcy-map-r "wcy-compose" "\
FUNCS is a list of functions. apply the functions to X and return a list of
return value

\(fn FUNCS X)" nil nil)

(autoload 'wcy-find-if "wcy-compose" "\
return a list whose car satisfy PRED

\(fn PRED A-LIST)" nil nil)

(defalias '$ 'wcy-partial-apply)

(defalias '$* 'wcy-partial-apply*)

(defalias '\. 'wcy-compose)

(autoload 'aif "wcy-compose" "\
Not documented

\(fn TEST-FORM THEN-FORM &optional ELSE-FORM)" nil (quote macro))

(autoload 'awhen "wcy-compose" "\
Not documented

\(fn TEST-FORM &rest THEN-FORM)" nil (quote macro))

(autoload 'awhile "wcy-compose" "\
Not documented

\(fn TEST-FORM &rest BODY)" nil (quote macro))

(autoload 'aand "wcy-compose" "\
Not documented

\(fn &rest ARGS)" nil (quote macro))

(autoload 'aprogn "wcy-compose" "\
Not documented

\(fn &rest BODY)" nil (quote macro))

(autoload 'call "wcy-compose" "\
Not documented

\(fn LIST-OF-FUNCTIONS &rest ARGS)" nil (quote macro))

;;;***

;;;### (autoloads (wcy-define-key-in-transient-mode) "wcy-define-key-in-transient-mode"
;;;;;;  "../my.elisp/wcy-define-key-in-transient-mode.el" (21831
;;;;;;  43253))
;;; Generated autoloads from ../my.elisp/wcy-define-key-in-transient-mode.el

(autoload 'wcy-define-key-in-transient-mode "wcy-define-key-in-transient-mode" "\
Not documented

\(fn GLOBAL-P KEY CMD-MARK-ACTIVE CMD-MARK-NO-ACTIVE)" nil nil)

;;;***

;;;### (autoloads (wcy-display-buffer-name) "wcy-display-buffer-name"
;;;;;;  "../my.elisp/wcy-display-buffer-name.el" (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-display-buffer-name.el

(autoload 'wcy-display-buffer-name "wcy-display-buffer-name" "\
Not documented

\(fn)" t nil)

;;;***

;;;### (autoloads (wcy-dot-emacs-is-done) "wcy-dot-emacs-is-done"
;;;;;;  "../my.elisp/wcy-dot-emacs-is-done.el" (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-dot-emacs-is-done.el

(autoload 'wcy-dot-emacs-is-done "wcy-dot-emacs-is-done" "\
Not documented

\(fn)" nil nil)

;;;***

;;;### (autoloads (wcy-edit-ac wcy-edit-my-elisp wcy-edit-abbrev
;;;;;;  wcy-edit-config-experimental wcy-edit-config) "wcy-edit-config"
;;;;;;  "../my.elisp/wcy-edit-config.el" (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-edit-config.el

(autoload 'wcy-edit-config "wcy-edit-config" "\
edit dot.emacs in my.config.

\(fn)" t nil)

(autoload 'wcy-edit-config-experimental "wcy-edit-config" "\
edit dot.emacs in my.elisp.experimental

\(fn)" t nil)

(autoload 'wcy-edit-abbrev "wcy-edit-config" "\
edit abbrevs

\(fn)" t nil)

(autoload 'wcy-edit-my-elisp "wcy-edit-config" "\
edit my elisp

\(fn)" t nil)

(autoload 'wcy-edit-ac "wcy-edit-config" "\
edit abbrevs

\(fn)" t nil)

;;;***

;;;### (autoloads (wcy-eval-if-installed) "wcy-eval-if-installed"
;;;;;;  "../my.elisp/wcy-eval-if-installed.el" (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-eval-if-installed.el

(autoload 'wcy-eval-if-installed "wcy-eval-if-installed" "\
Not documented

\(fn FILE &rest FORM)" nil (quote macro))

;;;***

;;;### (autoloads (wcy-global-set-key) "wcy-global-set-key" "../my.elisp/wcy-global-set-key.el"
;;;;;;  (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-global-set-key.el

(autoload 'wcy-global-set-key "wcy-global-set-key" "\
Not documented

\(fn &rest KEYS)" nil nil)

;;;***

;;;### (autoloads (wcy-toggle-shell wcy-toggle-shell-and-cd) "wcy-goto-shell"
;;;;;;  "../my.elisp/wcy-goto-shell.el" (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-goto-shell.el

(autoload 'wcy-toggle-shell-and-cd "wcy-goto-shell" "\
Not documented

\(fn ARG)" t nil)

(autoload 'wcy-toggle-shell "wcy-goto-shell" "\
Not documented

\(fn ARG)" t nil)

;;;***

;;;### (autoloads (wcy-init-my-package) "wcy-init-my-package" "../my.elisp/wcy-init-my-package.el"
;;;;;;  (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-init-my-package.el

(autoload 'wcy-init-my-package "wcy-init-my-package" "\
install all my package.

\(fn)" t nil)

;;;***

;;;### (autoloads (wcy-jekyll-insert-front-matter wcy-jekyll-new-post)
;;;;;;  "wcy-jekyll-new-post" "../my.elisp/wcy-jekyll-new-post.el"
;;;;;;  (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-jekyll-new-post.el

(autoload 'wcy-jekyll-new-post "wcy-jekyll-new-post" "\


\(fn TITLE)" t nil)

(autoload 'wcy-jekyll-insert-front-matter "wcy-jekyll-new-post" "\


\(fn TITLE)" t nil)

;;;***

;;;### (autoloads (wcy-kill-emacs) "wcy-kill-emacs" "../my.elisp/wcy-kill-emacs.el"
;;;;;;  (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-kill-emacs.el

(autoload 'wcy-kill-emacs "wcy-kill-emacs" "\
kill emacs when only one frame left, otherwise, delete selected frame

\(fn)" t nil)

;;;***

;;;### (autoloads (wcy-update-my\.elisp-directory-autoloads) "wcy-update-my.elisp-directory-autoloads"
;;;;;;  "../my.elisp/wcy-update-my.elisp-directory-autoloads.el"
;;;;;;  (21831 43253))
;;; Generated autoloads from ../my.elisp/wcy-update-my.elisp-directory-autoloads.el

(autoload 'wcy-update-my\.elisp-directory-autoloads "wcy-update-my.elisp-directory-autoloads" "\
Not documented

\(fn)" t nil)

;;;***

(provide '.loaddefs)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; .loaddefs.el ends here
