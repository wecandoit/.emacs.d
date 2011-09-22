;;; theo-general.el ---
;;
;; Copyright (c) 2007-2011 Theo Theo
;;
;; Author:
;; URL:
;; Version:
;; Keywords:

;; emacsclient
(server-start)

;; General
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1))

(setq initial-frame-alist '((top . 1)
                            (left . 1)
                            (width . 100)
                            (height . 45)))

(setq visible-bell t
      inhibit-startup-message t
      color-theme-is-global t
      shift-select-mode nil
      mouse-yank-at-point t
      x-select-enable-clipboard t
      require-final-newline t ; crontabs break without this
      truncate-partial-width-windows nil
      uniquify-buffer-name-style 'forward
      whitespace-style '(face trailing lines-tail tabs)
      whitespace-line-column 80
      ediff-window-setup-function 'ediff-setup-windows-plain
      oddmuse-directory "~/.emacs.d/oddmuse"
      save-place-file "~/.emacs.d/places")

;; Save a list of recent files visited.
(recentf-mode 1)

;; Save place in files between Sessions
(require 'saveplace)
(setq-default save-place t)

;; Delete trailing whitespace on save
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

(set-default 'indent-tabs-mode nil)
(set-default 'indicate-empty-lines t)
(set-default 'imenu-auto-rescan t)

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)

(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'auto-tail-revert-mode 'tail-mode)

(random t) ;; Seed the random-number generator

;; Hippie expand: at times perhaps too hip
(dolist (f '(try-expand-line try-expand-list try-complete-file-name-partially))
  (delete f hippie-expand-try-functions-list))

;; Add this back in at the end of the list.
(add-to-list 'hippie-expand-try-functions-list 'try-complete-file-name-partially t)

;; Don't clutter up directories with files~
(setq backup-directory-alist `(("." . ,(expand-file-name "~/.emacs.d/backups"))))

;; Color theme
(load-theme 'tango-dark)

;; from http://calvinyoung.org/2010/06/upgrading-backward-kill-word-in-emacs/
(defun my-backward-kill-word (&optional arg)
  "Replacement for the backward-kill-word command
If the region is active, then invoke kill-region.  Otherwise, use
the following custom backward-kill-word procedure.
If the previous word is on the same line, then kill the previous
word.  Otherwise, if the previous word is on a prior line, then kill
to the beginning of the line.  If point is already at the beginning
of the line, then kill to the end of the previous line.

With argument ARG and region inactive, do this that many times."
  (interactive "p")
  (if (use-region-p)
      (kill-region (mark) (point))
    (let (count)
      (dotimes (count arg)
        (if (bolp)
            (delete-backward-char 1)
          (kill-region (max (save-excursion (backward-word)(point))
                            (line-beginning-position))
                       (point)))))))

(global-set-key "\C-w" 'backward-kill-word)

(define-key (current-global-map) [remap backward-kill-word]
  'my-backward-kill-word)

;;
(windmove-default-keybindings 'meta)

(provide 'theo-general)
;;; theo-general.el ends here
