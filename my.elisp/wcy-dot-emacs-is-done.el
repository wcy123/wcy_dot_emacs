;;;;
;;;###autoload
(defun wcy-dot-emacs-is-done ()
  (setq initial-scratch-message
        (format
         "%s" 
         (concat ";; dot.emacs is successfully loaded.\n"
                 ";; SYS INIT time: " (format "%s seconds"
                                              (float-time 
                                               (time-subtract 
                                                (or after-init-time (current-time))
                                                before-init-time)))
                 "\n"
                 ";; USER INIT time: " (format "%s seconds"
                                               (float-time 
                                                (time-subtract 
                                                 (current-time)
                                                 before-init-time)))
           
                 ))))