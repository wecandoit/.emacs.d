(defconst theo-install-dir 
	(file-name-directory (or load-file-name
				(when (boundp 'bytecomp-filename) bytecomp-filename)
				buffer-file-name))
	"Installation directory of theo-emacs"
)

(add-to-list 'load-path theo-install-dir)
(require 'theo-packages)
(require 'theo-general)
(require 'theo-completion)
(require 'theo-python)
(require 'theo-js)
(require 'theo-ruby)

(provide 'theo-init)
