;; pip install 'python-lsp-server[all]'

(require 'lsp-mode)
(require 'lsp-ui)
(require 'python-mode)
(require 'flycheck)
(require 'yapfify)

(use-package python-mode
  :config
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (setq flycheck-checker 'python-pylint)

  :bind
  (:map python-mode-map
        ("C-c d" . lsp-find-definition)
        ("C-c r" . lsp-find-references)
        ("C-c n" . lsp-rename)
        ("C-c y" . yapfify-buffer))

  :hook
  ((python-mode . common-prog)
   (python-mode . lsp)
   (python-mode . flycheck-mode)))

(use-package lsp-ui
  :commands lsp-ui-mode)
