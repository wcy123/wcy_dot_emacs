;;;###autoload
(define-generic-mode lager-log-mode
  nil                                   ; comment
  nil                                   ; keyword
  `((,(concat"^\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\) "
             "\\([0-9]\\{2\\}:[0-9]\\{2\\}:[0-9]\\{2\\}\\.[0-9]\\{3\\}\\) ")
     . font-lock-comment-face)
    ("\\[\\(debug\\)\\] <.*>@" . font-lock-comment-face)
    ("\\[\\(info\\)\\] <.*>@" . font-lock-string-face)
    ("\\[\\(warning\\)\\] <.*>@" . font-lock-constant-face)
    ("\\[\\(error\\)\\] <.*>@" . font-lock-warning-face)
    ("ejabberd_receiver:process_data:" . font-lock-warning-face)
    ("ejabberd_socket:send:" . font-lock-warning-face)
    )
  '("ejabberd.log\\|console.log\\|debug.log")
  nil
  "generic mode for lager log file")
