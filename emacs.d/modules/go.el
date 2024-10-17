;; add to .bashrc:
;; export PATH=$PATH:$(go env GOPATH)/bin

(require 'go-mode)

(require 'use-package)
(require 'flycheck)
(require 'go-eldoc)
(require 'go-snippets)
(require 'gotest)
(require 'company)
(require 'lsp-mode)
(require 'lsp-ui)

(use-package go-mode
  :bind
  (:map go-mode-map
        ("C-c t" . go-test-current-test)
        ("C-c f" . go-test-current-file)
        ("C-c d" . lsp-find-definition)
        ("C-c r" . lsp-find-references)
        ("C-c i" . lsp-goto-implementation)
        ("C-c n" . lsp-rename)))

(defun my-go-mode-hook ()
  (common-prog)

  (setq tab-width 4)
  (setq indent-tabs-mode t)

  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t)

  (setq-default flycheck-disabled-checkers '(go-vet))

  (flycheck-mode)
  (yas-minor-mode)
  (go-eldoc-setup)
  (lsp-deferred))

(defun my-go-mode-hook-lite ()
  (common-prog)

  (setq tab-width 4)
  (setq indent-tabs-mode t)
  
  (add-hook 'before-save-hook 'gofmt-before-save)
  (yas-minor-mode)
  (flycheck-mode))

(add-hook 'go-mode-hook 'my-go-mode-hook)
