;;; .loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (wcy-add-local-variable-for-file) "../my.elisp/wcy-add-local-variable-for-file"
;;;;;;  "../my.elisp/wcy-add-local-variable-for-file.el" (21796 54089))
;;; Generated autoloads from ../my.elisp/wcy-add-local-variable-for-file.el

(autoload 'wcy-add-local-variable-for-file "../my.elisp/wcy-add-local-variable-for-file" "\


\(fn)" t nil)

;;;***

;;;***

;;;### (autoloads nil "../my.elisp/wcy-backup-buffer" "../my.elisp/wcy-backup-buffer.el"
;;;;;;  (21830 6364 0 0))
;;; Generated autoloads from ../my.elisp/wcy-backup-buffer.el

;;;### (autoloads nil "../my.elisp/wcy-c-mode-hook" "../my.elisp/wcy-c-mode-hook.el"
;;;;;;  (21825 55238 0 0))
;;; Generated autoloads from ../my.elisp/wcy-c-mode-hook.el

(autoload 'wcy-c-mode-hook "../my.elisp/wcy-c-mode-hook" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-c-open-other-file" "../my.elisp/wcy-c-open-other-file.el"
;;;;;;  (21797 59806 0 0))
;;; Generated autoloads from ../my.elisp/wcy-c-open-other-file.el

(autoload 'wcy-c-open-other-file "../my.elisp/wcy-c-open-other-file" "\
if current file is a header file, then open the
corresponding source file or vice versa.

\(fn)" t nil)

;;;***

;;;### (autoloads (wcy-complete) "../my.elisp/wcy-complete" "../my.elisp/wcy-complete.el"
;;;;;;  (21796 54089))
;;; Generated autoloads from ../my.elisp/wcy-complete.el

(autoload 'wcy-complete "../my.elisp/wcy-complete" "\


\(fn)" t nil)

;;;***

;;;### (autoloads (call aprogn aand awhile awhen aif wcy-find-if
;;;;;;  wcy-map-r wcy-flip wcy-partial-apply* wcy-partial-apply wcy-compose)
;;;;;;  "../my.elisp/wcy-compose" "../my.elisp/wcy-compose.el" (21796
;;;;;;  54089))
;;; Generated autoloads from ../my.elisp/wcy-compose.el

(autoload 'wcy-compose "../my.elisp/wcy-compose" "\


\(fn &rest FSV)" nil (quote macro))

(autoload 'wcy-partial-apply "../my.elisp/wcy-compose" "\
partialy apply the function and return a new function with
fewer arguments

\(fn F &rest ARGS)" nil (quote macro))

(autoload 'wcy-partial-apply* "../my.elisp/wcy-compose" "\
partialy apply the function and return a new function with
fewer arguments

\(fn F &rest ARGS)" nil (quote macro))

(autoload 'wcy-flip "../my.elisp/wcy-compose" "\


\(fn F)" nil (quote macro))

(autoload 'wcy-map-r "../my.elisp/wcy-compose" "\
FUNCS is a list of functions. apply the functions to X and return a list of
return value

\(fn FUNCS X)" nil nil)

(autoload 'wcy-find-if "../my.elisp/wcy-compose" "\
return a list whose car satisfy PRED

\(fn PRED A-LIST)" nil nil)

(defalias '$ 'wcy-partial-apply)

(defalias '$* 'wcy-partial-apply*)

(defalias '\. 'wcy-compose)

(autoload 'aif "../my.elisp/wcy-compose" "\


\(fn TEST-FORM THEN-FORM &optional ELSE-FORM)" nil (quote macro))

(autoload 'awhen "../my.elisp/wcy-compose" "\


\(fn TEST-FORM &rest THEN-FORM)" nil (quote macro))

(autoload 'awhile "../my.elisp/wcy-compose" "\


\(fn TEST-FORM &rest BODY)" nil (quote macro))

(autoload 'aand "../my.elisp/wcy-compose" "\


\(fn &rest ARGS)" nil (quote macro))

(autoload 'aprogn "../my.elisp/wcy-compose" "\


\(fn &rest BODY)" nil (quote macro))

(autoload 'call "../my.elisp/wcy-compose" "\


\(fn LIST-OF-FUNCTIONS &rest ARGS)" nil (quote macro))

;;;***

;;;### (autoloads (wcy-display-buffer-name) "../my.elisp/wcy-display-buffer-name"
;;;;;;  "../my.elisp/wcy-display-buffer-name.el" (21796 54089))
;;; Generated autoloads from ../my.elisp/wcy-display-buffer-name.el

(autoload 'wcy-display-buffer-name "../my.elisp/wcy-display-buffer-name" "\


\(fn)" t nil)

;;;***

;;;### (autoloads (wcy-dot-emacs-is-done) "../my.elisp/wcy-dot-emacs-is-done"
;;;;;;  "../my.elisp/wcy-dot-emacs-is-done.el" (21796 54089))
;;; Generated autoloads from ../my.elisp/wcy-dot-emacs-is-done.el

(autoload 'wcy-dot-emacs-is-done "../my.elisp/wcy-dot-emacs-is-done" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads (wcy-edit-ac wcy-edit-my-elisp wcy-edit-abbrev
;;;;;;  wcy-edit-config-experimental wcy-edit-config) "../my.elisp/wcy-edit-config"
;;;;;;  "../my.elisp/wcy-edit-config.el" (21796 54089))
;;; Generated autoloads from ../my.elisp/wcy-edit-config.el

(autoload 'wcy-edit-config "../my.elisp/wcy-edit-config" "\
edit dot.emacs in my.config.

\(fn)" t nil)

(autoload 'wcy-edit-config-experimental "../my.elisp/wcy-edit-config" "\
edit dot.emacs in my.elisp.experimental

\(fn)" t nil)

(autoload 'wcy-edit-abbrev "../my.elisp/wcy-edit-config" "\
edit abbrevs

\(fn)" t nil)

(autoload 'wcy-edit-my-elisp "../my.elisp/wcy-edit-config" "\
edit my elisp

\(fn)" t nil)

(autoload 'wcy-edit-ac "../my.elisp/wcy-edit-config" "\
edit abbrevs

\(fn)" t nil)

;;;***

;;;### (autoloads (wcy-eval-if-installed) "../my.elisp/wcy-eval-if-installed"
;;;;;;  "../my.elisp/wcy-eval-if-installed.el" (21796 54089))
;;; Generated autoloads from ../my.elisp/wcy-eval-if-installed.el

(autoload 'wcy-eval-if-installed "../my.elisp/wcy-eval-if-installed" "\


\(fn FILE &rest FORM)" nil (quote macro))

;;;***

;;;### (autoloads (wcy-global-set-key) "../my.elisp/wcy-global-set-key"
;;;;;;  "../my.elisp/wcy-global-set-key.el" (21796 54089))
;;; Generated autoloads from ../my.elisp/wcy-global-set-key.el

(autoload 'wcy-global-set-key "../my.elisp/wcy-global-set-key" "\


\(fn &rest KEYS)" nil nil)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-goto-shell" "../my.elisp/wcy-goto-shell.el"
;;;;;;  (21796 56083 0 0))
;;; Generated autoloads from ../my.elisp/wcy-goto-shell.el

(autoload 'wcy-toggle-shell-and-cd "../my.elisp/wcy-goto-shell" "\


\(fn ARG)" t nil)

(autoload 'wcy-toggle-shell "../my.elisp/wcy-goto-shell" "\


\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-init-my-package" "../my.elisp/wcy-init-my-package.el"
;;;;;;  (21797 57969 0 0))
;;; Generated autoloads from ../my.elisp/wcy-init-my-package.el

(autoload 'wcy-init-my-package "../my.elisp/wcy-init-my-package" "\
install all my package.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-jekyll-new-post" "../my.elisp/wcy-jekyll-new-post.el"
;;;;;;  (21796 63173 0 0))
;;; Generated autoloads from ../my.elisp/wcy-jekyll-new-post.el

(autoload 'wcy-jekyll-new-post "../my.elisp/wcy-jekyll-new-post" "\


\(fn TITLE)" t nil)

(autoload 'wcy-jekyll-insert-front-matter "../my.elisp/wcy-jekyll-new-post" "\


\(fn TITLE)" t nil)

;;;***

;;;### (autoloads (wcy-kill-emacs) "../my.elisp/wcy-kill-emacs" "../my.elisp/wcy-kill-emacs.el"
;;;;;;  (21796 54089))
;;; Generated autoloads from ../my.elisp/wcy-kill-emacs.el

(autoload 'wcy-kill-emacs "../my.elisp/wcy-kill-emacs" "\
kill emacs when only one frame left, otherwise, delete selected frame

\(fn)" t nil)
;;;***

;;;### (autoloads nil "../my.elisp/wcy-kill-next-move" "../my.elisp/wcy-kill-next-move.el"
;;;;;;  (21827 43714 0 0))
;;; Generated autoloads from ../my.elisp/wcy-kill-next-move.el

(autoload 'wcy-kill-next-move "../my.elisp/wcy-kill-next-move" "\
kill until the next movement

\(fn KEY)" t nil)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-read-variable" "../my.elisp/wcy-read-variable.el"
;;;;;;  (21546 5479 0 0))
;;; Generated autoloads from ../my.elisp/wcy-read-variable.el

(autoload 'wcy-read-variable "../my.elisp/wcy-read-variable" "\
read a varable

\(fn PROMPT PREDICATE &optional DEFAULT)" nil nil)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-search-file-in-parent-dir"
;;;;;;  "../my.elisp/wcy-search-file-in-parent-dir.el" (21797 59828
;;;;;;  0 0))
;;; Generated autoloads from ../my.elisp/wcy-search-file-in-parent-dir.el

(autoload 'wcy-search-file-in-parent-dir "../my.elisp/wcy-search-file-in-parent-dir" "\


\(fn FILE-LIST DIR &optional PRED)" nil nil)

;;;***

;;;***

;;;***

;;;### (autoloads nil "../my.elisp/wcy-transient-mode" "../my.elisp/wcy-transient-mode.el"
;;;;;;  (21824 36202 0 0))
;;; Generated autoloads from ../my.elisp/wcy-transient-mode.el

;;;### (autoloads nil "../my.elisp/wcy-update-my.elisp-directory-autoloads"
;;;;;;  "../my.elisp/wcy-update-my.elisp-directory-autoloads.el"
;;;;;;  (21796 53882 0 0))
;;; Generated autoloads from ../my.elisp/wcy-update-my.elisp-directory-autoloads.el

(autoload 'wcy-update-my\.elisp-directory-autoloads "../my.elisp/wcy-update-my.elisp-directory-autoloads" "\


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
