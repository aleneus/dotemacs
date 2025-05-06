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
        ("C-c n" . lsp-rename))

  :hook
  ((python-mode . (lambda ()
                    (add-hook 'before-save-hook
                              'yapfify-buffer
                              nil
                              t)))
   (python-mode . common-prog)
   (python-mode . lsp-deferred)
   (python-mode . flycheck-mode)))

(use-package lsp-ui
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode))
