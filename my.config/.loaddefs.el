;;; .loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "../my.elisp/wcy-add-local-variable-for-file"
;;;;;;  "../my.elisp/wcy-add-local-variable-for-file.el" (21796 44530
;;;;;;  0 0))
;;; Generated autoloads from ../my.elisp/wcy-add-local-variable-for-file.el

(autoload 'wcy-add-local-variable-for-file "../my.elisp/wcy-add-local-variable-for-file" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-complete" "../my.elisp/wcy-complete.el"
;;;;;;  (21796 44530 0 0))
;;; Generated autoloads from ../my.elisp/wcy-complete.el

(autoload 'wcy-complete "../my.elisp/wcy-complete" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-compose" "../my.elisp/wcy-compose.el"
;;;;;;  (21796 44530 0 0))
;;; Generated autoloads from ../my.elisp/wcy-compose.el

(autoload 'wcy-compose "../my.elisp/wcy-compose" "\


\(fn &rest FSV)" nil t)

(autoload 'wcy-partial-apply "../my.elisp/wcy-compose" "\
partialy apply the function and return a new function with
fewer arguments

\(fn F &rest ARGS)" nil t)

(autoload 'wcy-partial-apply* "../my.elisp/wcy-compose" "\
partialy apply the function and return a new function with
fewer arguments

\(fn F &rest ARGS)" nil t)

(autoload 'wcy-flip "../my.elisp/wcy-compose" "\


\(fn F)" nil t)

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


\(fn TEST-FORM THEN-FORM &optional ELSE-FORM)" nil t)

(autoload 'awhen "../my.elisp/wcy-compose" "\


\(fn TEST-FORM &rest THEN-FORM)" nil t)

(autoload 'awhile "../my.elisp/wcy-compose" "\


\(fn TEST-FORM &rest BODY)" nil t)

(autoload 'aand "../my.elisp/wcy-compose" "\


\(fn &rest ARGS)" nil t)

(autoload 'aprogn "../my.elisp/wcy-compose" "\


\(fn &rest BODY)" nil t)

(autoload 'call "../my.elisp/wcy-compose" "\


\(fn LIST-OF-FUNCTIONS &rest ARGS)" nil t)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-define-key-in-transient-mode"
;;;;;;  "../my.elisp/wcy-define-key-in-transient-mode.el" (21796
;;;;;;  44530 0 0))
;;; Generated autoloads from ../my.elisp/wcy-define-key-in-transient-mode.el

(autoload 'wcy-define-key-in-transient-mode "../my.elisp/wcy-define-key-in-transient-mode" "\


\(fn GLOBAL-P KEY CMD-MARK-ACTIVE CMD-MARK-NO-ACTIVE)" nil nil)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-display-buffer-name" "../my.elisp/wcy-display-buffer-name.el"
;;;;;;  (21796 44530 0 0))
;;; Generated autoloads from ../my.elisp/wcy-display-buffer-name.el

(autoload 'wcy-display-buffer-name "../my.elisp/wcy-display-buffer-name" "\


\(fn)" t nil)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-dot-emacs-is-done" "../my.elisp/wcy-dot-emacs-is-done.el"
;;;;;;  (21796 48546 0 0))
;;; Generated autoloads from ../my.elisp/wcy-dot-emacs-is-done.el

(autoload 'wcy-dot-emacs-is-done "../my.elisp/wcy-dot-emacs-is-done" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-edit-config" "../my.elisp/wcy-edit-config.el"
;;;;;;  (21796 44530 0 0))
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

;;;### (autoloads nil "../my.elisp/wcy-eval-if-installed" "../my.elisp/wcy-eval-if-installed.el"
;;;;;;  (21796 44530 0 0))
;;; Generated autoloads from ../my.elisp/wcy-eval-if-installed.el

(autoload 'wcy-eval-if-installed "../my.elisp/wcy-eval-if-installed" "\


\(fn FILE &rest FORM)" nil t)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-global-set-key" "../my.elisp/wcy-global-set-key.el"
;;;;;;  (21796 44530 0 0))
;;; Generated autoloads from ../my.elisp/wcy-global-set-key.el

(autoload 'wcy-global-set-key "../my.elisp/wcy-global-set-key" "\


\(fn &rest KEYS)" nil nil)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-kill-emacs" "../my.elisp/wcy-kill-emacs.el"
;;;;;;  (21796 44530 0 0))
;;; Generated autoloads from ../my.elisp/wcy-kill-emacs.el

(autoload 'wcy-kill-emacs "../my.elisp/wcy-kill-emacs" "\
kill emacs when only one frame left, otherwise, delete selected frame

\(fn)" t nil)

;;;***

;;;### (autoloads nil "../my.elisp/wcy-update-my.elisp-directory-autoloads"
;;;;;;  "../my.elisp/wcy-update-my.elisp-directory-autoloads.el"
;;;;;;  (21796 44530 0 0))
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
