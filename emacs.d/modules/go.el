(require 'use-package)

(use-package go-mode
  ;; add to .profile:
  ;; export PATH=$PATH:$(go env GOPATH)/bin
  :config
  (require 'flycheck)
  (require 'go-eldoc)
  (require 'go-snippets)
  (require 'gotest)
  (require 'xref)
  (require 'lsp-mode)
  (require 'lsp-ui)

  :bind
  (:map go-mode-map
        ("C-c t" . go-test-current-test)
        ("C-c f" . go-test-current-file)
        ("C-c d" . lsp-find-definition)
        ("C-c r" . lsp-find-references)
        ("C-c i" . lsp-goto-implementation)
        ("C-c n" . lsp-rename))

  :hook
  (go-mode
   . (lambda ()
       (common-prog)

       (setq tab-width 4)
       (setq indent-tabs-mode t)

       (add-hook 'before-save-hook #'lsp-format-buffer t t)
       (add-hook 'before-save-hook #'lsp-organize-imports t t)

       (setq-default flycheck-disabled-checkers '(go-vet))

       (flycheck-mode)
       (yas-minor-mode)
       (go-eldoc-setup)
       (lsp-deferred))))
