;;; tmux-cc.el --- control tmux via emacs            -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Chunye Wang

;; Author: Chunye Wang <chunywan@xbjlabdpsvr15>
;; Keywords: emulations, terminals

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:



(defvar tmux-cc-delimiter-begin "^```\n"
  "begin of a delimter")
(defvar tmux-cc-delimiter-end "^```\n"
  "end of a delimter")
(defun tmux-cc--convert-keys(strings)
  (seq-map #'(lambda(c) (format "%x" c)) strings))
;;(tmux-cc--convert-keys "hello")
(defun tmux-cc-send-keys (strings)
  (let ((ret (apply #'call-process `("tmux" nil "*tmux cc*" t
                           "send-keys" "-t" "1" "-H" ,@(tmux-cc--convert-keys
                                                        strings)))))
    (message "call return %S" ret)))
(defun tmux-cc-send-region(begin end)
  (interactive "r")
  (unless mark-active
    (error "no region is selected"))
  (let ((content (buffer-substring begin end)))
    (tmux-cc-send-keys content)))

(defun tmux-cc-send-current-line ()
  (interactive)
  (tmux-cc-send-keys (buffer-substring (line-beginning-position) (+  1 (line-end-position)))))


(defun tmux-cc--search-end ()
  (save-excursion
    (when (search-forward-regexp tmux-cc-delimiter-begin nil t nil)
      (match-beginning 0))))

(defun tmux-cc--search-begin ()
  (save-excursion
    (when (search-backward-regexp tmux-cc-delimiter-end nil t nil)
      (match-end 0))))

(defun tmux-cc-select-block ()
  (interactive)
  (let ((begin (tmux-cc--search-begin))
        (end (tmux-cc--search-end)))
    (when (and begin end)
      (push-mark begin nil t)
      (goto-char end))))
(global-set-key (kbd "M-5") 'tmux-cc-send-region)
(global-set-key (kbd "M-6") 'tmux-cc-select-block)
;; (global-set-key (kbd "M-6") 'tmux-cc-send-current-line)

(provide 'tmux-cc)
;;; tmux-cc.el ends here
