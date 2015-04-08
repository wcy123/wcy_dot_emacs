;;; wcy-compose.el --- some helper function that is not defined by default

;; Copyright (C) 2009  

;; Author:  <chunywan@3CNL03982>
;; Keywords: 

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; 

;;; Code:
(defvar wcy-function-var nil
  "temp variable to avoid warning message")
(defun wcy-function (f)
  (cond
   ((symbolp f) (list 'quote f))
   ((and (symbolp f)
	 (fboundp f)
	 (subrp (symbol-function f))) (list 'quote f))
   ((and (symbolp f)
	 (fboundp f)) (list 'quote f))
   ((functionp f) f)
   (t f)))
;;;###autoload 
(defmacro wcy-compose (&rest fsv)
  (let* ((fs (reverse fsv))
	 (args (make-symbol "args"))
	 (form args))
    (if (null fs)
	(error "at least one function needed"))
    (setq form `(apply ,(wcy-function (car fs)) ,args)
	  fs (cdr fs))
    (while fs
      (setq form `(funcall ,(wcy-function (car fs)) ,form)
	    fs (cdr fs)))
    `(lambda (&rest ,args)
       (,@form))))
(defun wcy-partial-apply-helper-func (args arg_rest)
  (mapcar
   #'(lambda (arg)
       (if (and (symbolp arg)
                  (string-match "\\`_\\([0-9]+\\)\\'" (symbol-name arg)))
         (let ((pos (string-to-number (match-string 1 (symbol-name arg)))))           
           (list 'nth (1- pos) arg_rest))
         arg))
   args))
;;;###autoload 
(defmacro wcy-partial-apply (f &rest args)
  "partialy apply the function and return a new function with
fewer arguments"
  (let ((x (make-symbol "x")))
    `(lambda (&rest ,x)
       (apply ,(wcy-function f) ,@args ,x))))
;;;###autoload 
(defmacro wcy-partial-apply* (f &rest args)
  "partialy apply the function and return a new function with
fewer arguments"
  (let ((x (make-symbol "x")))
    `(lambda (&rest ,x)
       (funcall ,(wcy-function f) ,@(wcy-partial-apply-helper-func args x)))))
;;;###autoload 
(defmacro wcy-flip (f)
  (let ((x (make-symbol "x"))
	(y (make-symbol "y")))
    (list 'lambda (list x y)
	  (list 'funcall (wcy-function f) y x))))
;;;###autoload
(defun wcy-map-r (funcs x)
  "FUNCS is a list of functions. apply the functions to X and return a list of
return value"
  (mapcar ($ (wcy-flip funcall) x) funcs))
;;;###autoload
(defun wcy-find-if (pred a-list)
  "return a list whose car satisfy PRED"
  (while (and a-list (not (funcall pred (car a-list))))
    (setq a-list (cdr a-list)))
  a-list)
;;;###autoload 
(defalias '$ 'wcy-partial-apply)
;;;###autoload 
(defalias '$* 'wcy-partial-apply*)
;;;###autoload 
(defalias '\. 'wcy-compose)
;;;###autoload
(defmacro aif (test-form then-form &optional else-form)
  `(let ((it ,test-form))
     (if it ,then-form ,else-form)))
(setplist 'aif (symbol-plist 'if))
;;;###autoload 
(defmacro awhen (test-form &rest then-form)
  `(let ((it ,test-form))
     (when it ,@then-form)))
(setplist 'awhen(symbol-plist 'when))
(defmacro aunless (test-form &rest then-form)
  `(let ((it ,test-form))
     (unless it ,@then-form)))
(setplist 'aunless (symbol-plist 'unless))
;;;###autoload 
(defmacro awhile (test-form &rest body)
  `(let (it)
     (while (setq it ,test-form)
       ,@body)))
(setplist 'awhile (symbol-plist 'while))

;;;###autoload
(defmacro aand (&rest args)
  (cond ((null args) t)
        ((null (cdr args)) (car args))
        (t `(aif ,(car args) (aand ,@(cdr args))))))
;;;###autoload
(defmacro aprogn (&rest body)
  `(let ((it (and (boundp 'it) it)))
     ,@(mapcar #'(lambda (exp)
                   `(setq it ,exp))
               body)))
(setplist 'aprogn (symbol-plist 'progn))
;;;###autoload 
(defmacro call (list-of-functions &rest args)
  `(funcall (\. ,@list-of-functions) ,@args))
    
(provide 'wcy-compose)
;;; wcy-compose.el ends here
