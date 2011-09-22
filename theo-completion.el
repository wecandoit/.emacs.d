;; Hippie expand: at times perhaps too hip
(dolist (f '(try-expand-line try-expand-list try-complete-file-name-partially))
  (delete f hippie-expand-try-functions-list))

;; Add this back in at the end of the list.
(add-to-list 'hippie-expand-try-functions-list 'try-complete-file-name-partially t)

;; Ido
(require 'ido)
(setq
  ido-use-filename-at-point nil
  ido-use-url-at-point t
  ido-save-directory-list-file "~/.emacs.d/ido.last"
  ido-enable-flex-matching t ;; enable fuzzy matching 
  )
(ido-mode t)  

;; Yasnippet
(add-to-list 'load-path "~/.emacs.d/el-get/yasnippet/yasnippet.el")
(require 'yasnippet)
(yas/initialize)
(setq yas/root-directory "~/.emacs.d/el-get/yasnippet/snippets")
(yas/load-directory yas/root-directory)

;; zencoding
(define-key zencoding-mode-keymap (kbd "M-RET") 'zencoding-expand-line)

;; auto-complete
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)

(provide 'theo-completion)
