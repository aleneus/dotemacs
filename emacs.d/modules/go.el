;; add to .bashrc:
;; export PATH=$PATH:$(go env GOPATH)/bin

(use-package company
  :ensure t)

(use-package flycheck
  :ensure t)

(use-package go-eldoc
  :ensure t)

(use-package go-snippets
  :ensure t)

(use-package gotest
  :ensure t)

(use-package lsp-mode
  :ensure t)

(use-package lsp-ui
  :ensure t)

(use-package use-package
  :ensure t)

(defun my-go-mode-hook-base ()
  (common-prog)

  (setq tab-width 4)
  (setq indent-tabs-mode t)

  (add-hook 'before-save-hook 'gofmt-before-save)

  (setq-default flycheck-disabled-checkers '(go-vet))

  (flycheck-mode)
  (yas-minor-mode))

(defun my-go-mode-hook ()
  (my-go-mode-hook-base)

  (add-hook 'before-save-hook #'lsp-organize-imports t t)

  (go-eldoc-setup)
  (lsp-deferred))

(add-hook 'go-mode-hook 'my-go-mode-hook)

(use-package go-mode
  :ensure t
  :bind
  (:map go-mode-map
		("C-c t" . go-test-current-test)
		("C-c f" . go-test-current-file)
		("C-c d" . lsp-find-definition)
		("C-c r" . lsp-find-references)
		("C-c i" . lsp-goto-implementation)
		("C-c n" . lsp-rename))
  :hook
  (go-mode . my-go-mode-hook))
