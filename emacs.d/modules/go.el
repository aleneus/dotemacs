;; add to .bashrc:
;; export PATH=$PATH:$(go env GOPATH)/bin

(require 'company)
(require 'flycheck)
(require 'go-eldoc)
(require 'go-snippets)
(require 'gotest)
(require 'lsp-mode)
(require 'lsp-ui)
(require 'use-package)

(use-package go-mode
  :bind
  (:map go-mode-map
        ("C-c t" . go-test-current-test)
        ("C-c f" . go-test-current-file)
        ("C-c d" . lsp-find-definition)
        ("C-c r" . lsp-find-references)
        ("C-c i" . lsp-goto-implementation)
        ("C-c n" . lsp-rename)))

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
