(add-to-list 'ac-sources 'ac-source-yasnippet)

(require 'flymake-jslint)

(setq inferior-js-program-command "node")

(setq inferior-js-mode-hook
      (lambda ()
	(ansi-color-for-comint-mode-on)
	(add-to-list 'comint-preoutput-filter-functions
		     (lambda (output)
		       (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
						 (replace-regexp-in-string ".*1G.*3G" "&gt;" output))))))

(add-hook 'js2-hook-mode
	  (lambda ()
	    (imenu-add-menubar-index)
	    (hs-minor-mode)
	    (jquery-doc-setup)))

(provide 'theo-js)
