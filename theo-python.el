;; Python
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; IPython
(setq ipython-command "/usr/bin/ipython")
(add-to-list 'load-path "~/.emacs.d/el-get/ipython")
(require 'ipython)
(setq py-python-command-args '("-pylab" "-colors" "LightBG"))

;; Initialize Pymacs
(require 'pymacs)
;; (setq pymacs-load-path '( "~/.emacs.d/python-libs/rope"
;;                            "~/.emacs.d/python-libs/ropemode"
;;                            "~/.emacs.d/python-libs/ropemacs"
;;                            "~/.emacs.d/python-libs/Pymacs"))
(setq python-python-command "ipython")
;;(add-to-list 'load-path "~/.emacs.d/el-get/pymacs/")

(setenv "PYTHONPATH"
	(concat
	 (getenv "PYTHONPATH") path-separator
	 (concat theo-install-dir "python-libs/")))

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

;; Initialize Rope
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;; Stops from erroring if there's a syntax err
;; (setq ropemacs-codeassist-maxfixes 3)
(setq ropemacs-guess-project t)
(setq ropemacs-enable-autoimport t)

;; Adding hook to automatically open a rope project if there is one
;; in the current or in the upper level directory
(add-hook 'python-mode-hook
          (lambda ()
            (cond ((file-exists-p ".ropeproject")
                   (rope-open-project default-directory))
                  ((file-exists-p "../.ropeproject")
                   (rope-open-project (concat default-directory "..")))
                  )))
;; Auto-complete
(add-to-list 'load-path "~/.emacs.d/el-get/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/el-get/auto-complete/dict")
(ac-config-default)

(ac-ropemacs-initialize)
(add-hook 'python-mode-hook
            (lambda () (add-to-list 'ac-sources 'ac-source-ropemacs)))

;; Flymake
(add-hook 'find-file-hook 'flymake-find-file-hook)

;; (setq
;;  py-pychecker-command "~/.emacs.d/pychecker"
;;  py-pychecker-command-args (quote (""))
;;  python-check-command "~/.emacs.d/pychecker")
;; http://stackoverflow.com/questions/1259873/how-can-i-use-emacs-flymake-mode-for-python-with-pyflakes-and-pylint-checking-cod/1393590#1393590
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.emacs.d/pychecker"  (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

(load-library "flymake-cursor")
(global-set-key [f10] 'flymake-goto-prev-error)
(global-set-key [f11] 'flymake-goto-next-error)

;; Autopair
(require 'autopair)
(add-hook 'python-mode-hook
          (lambda ()
            (push '(?' . ?')
                  (getf autopair-extra-pairs :code))
            (setq autopair-handle-action-fns
                  (list #'autopair-default-handle-action  #'autopair-python-triple-quote-action))))

;; Execute python code region @ jilly-emacs
(defun rgr/python-execute()
  (interactive)
  (if mark-active
      (py-execute-string (buffer-substring-no-properties (region-beginning) (region-end)))
    (py-execute-buffer)))
(global-set-key (kbd "C-c C-e") 'rgr/python-execute)

(provide 'theo-python)
