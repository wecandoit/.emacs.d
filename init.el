(setq theo-kit-dir
	(file-name-directory (or load-file-name (buffer-file-name))))

(load-file (expand-file-name "theo-init.el" theo-kit-dir))
