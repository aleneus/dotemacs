;; pip install 'python-lsp-server[all]'
;; pip install pylint

(use-package flycheck
  :ensure t)

(use-package yapfify
  :ensure t)

(use-package python-mode
  :ensure t

  :config
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (setq flycheck-checker 'python-pylint)

  :hook
  (python-mode . (lambda ()
				   (eglot-ensure)
				   (flycheck-mode)
				   (add-hook 'before-save-hook 'yapfify-buffer nil t)
				   (common-prog)
				   (define-key python-mode-map (kbd "C-c d") 'xref-find-definitions)
				   (define-key python-mode-map (kbd "C-c r") 'xref-find-references)
				   (define-key python-mode-map (kbd "C-c n") 'eglot-rename)
				   (setq comment-start "# "))))

(use-package eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs
			   '(python-mode . ("pylsp"))))

(use-package company
  :ensure t
  :hook (python-mode . company-mode))
