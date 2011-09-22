(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(setq
 el-get-sources
 '(
   el-get               ; el-get is self-hosting

   ;; compliation
   (:name smex              ; a better (ido like) M-x
          :after (lambda ()
                   (setq smex-save-file "~/.emacs.d/.smex-items")
                   (global-set-key (kbd "M-x") 'smex)
                   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))

   auto-complete            ; complete as you type with overlays
   (:name yasnippet
          :compile nil)
   autopair
   ;; python & django
   python-mode
   ipython
   virtualenv
   pymacs
   (:name pony-mode
          :type git
          :url "https://github.com/davidmiller/pony-mode.git"
          :features "pony-mode"
          :after (lambda()
                   (add-to-list 'load-path (concat el-get-dir "pony-mode"))))

   ;; ruby
   ruby-compilation
   ruby-block
   rhtml-mode
   (:name inf-ruby 
	  :type elpa)
   rvm
   flymake-ruby
   rinari

   ;; yaml
   yaml-mode

   ;; php
   php-mode-improved            ; if you're into php...

  ;; javascript
   js2-mode
   js-comint
   (:name jquery-doc
      :type git
      :url "https://github.com/ananthakumaran/jquery-doc.el"
      :features "jquery-doc")
   (:name lintnode
      :type git
      :url "https://github.com/davidmiller/lintnode.git"
      :features "flymake-jslint"
      :after (lambda ()
           (add-to-list 'load-path  (concat el-get-dir "lintnode"))
           (setq lintnode-location (concat el-get-dir "lintnode"))
           (setq lintnode-jslint-excludes
             (list 'nomen
                   'undef
                   'plusplus
                   'onevar
                   'white))
           (add-hook 'js-mode-hook
                 (lambda ()
                   (lintnode-hook)))))
   ;; html, css
   nxhtml
   zencoding-mode           ; http://www.emacswiki.org/emacs/ZenCoding
   rainbow-mode

   ;; parenthesis & indentation
   paredit
   rainbow-delimiters
   highlight-indentation

   ;; flymake
   (:name flymake-cursor
      :type emacswiki
      :features "flymake-cursor")

   ;; frames
   minimap          ; the sidebar showing a small version of your buffer
   escreen          ; screen for emacs, C-\ C-h
   switch-window            ; takes over C-x o
   (:name buffer-move           ; have to add your own keys
          :after (lambda ()
               (global-set-key (kbd "<C-S-up>")     'buf-move-up)
               (global-set-key (kbd "<C-S-down>")   'buf-move-down)
               (global-set-key (kbd "<C-S-left>")   'buf-move-left)
               (global-set-key (kbd "<C-S-right>")  'buf-move-right)))

   ;; vcs
   (:name magit                 ; git meet emacs, and a binding
      :after (lambda ()
           (global-set-key (kbd "C-x C-z") 'magit-status)))
   ;; other
   (:name goto-last-change      ; move pointer back to last change
      :after (lambda ()
           ;; when using AZERTY keyboard, consider C-x C-_
           (global-set-key (kbd "C-x C-/") 'goto-last-change)))
   vkill
   ))

(setq my-packages
      (append
       '("cssh")
       (mapcar 'el-get-source-name el-get-sources)))
(el-get 'sync my-packages)
;(el-get 'sync el-get-sources)

(provide 'theo-packages)
