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

(defun tmux-cc--convert-keys(strings)
  (seq-map #'(lambda(c) (format "%x" c)) strings))
;;(tmux-cc--convert-keys "hello")
(defun tmux-cc-send-keys (strings)
  (apply #'call-process `("tmux" nil nil nil
                           "send-keys" "-t" "1" "-H" ,@(tmux-cc--convert-keys
                                                        strings))))
(defun tmux-cc-send-region(begin end)
  (interactive "r")
  (unless mark-active
    (error "no region is selected"))
  (let ((content (buffer-substring begin end)))
    (tmux-cc-send-keys content)))

(defun tmux-cc-select-block ()
  (interactive)
  (let ((begin (save-excursion (search-backward "\f\n" nil t nil)))
        (end (save-excursion (search-forward "\f\n" nil t nil))))
    (when (and begin end)
      (push-mark (- end 2) nil t)
      (goto-char (+ 2 begin)))))
(provide 'tmux-cc)
;;; tmux-cc.el ends here
