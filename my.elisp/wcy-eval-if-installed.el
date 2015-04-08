;;;###autoload
(defmacro wcy-eval-if-installed (file &rest form)
  `(when (locate-file ,file load-path '(".elc" ".el")) ,@form))

(put 'wcy-eval-if-installed 'lisp-indent-function 1)
