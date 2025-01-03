;; IMPORTANT! pip3 install yapf=0.40.1

(require 'use-package)
(require 'py-yapf)
(require 'flycheck)

(use-package elpy
  :ensure t

  :config
  (setq elpy-rpc-python-command "python3")
  (setq elpy-rpc-virtualenv-path 'current)

  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (setq flycheck-checker 'python-pylint)

  :init
  (elpy-enable)

  :bind (:map elpy-mode-map
              ("C-c C-d" . elpy-doc)
              ("C-c d" . elpy-goto-definition)
              ("C-c x v" . elpy-refactor-extract-variable)
              ("C-c x f" . elpy-refactor-extract-function))

  :hook ((elpy-mode . (lambda ()
                        (add-hook 'before-save-hook
                                  'elpy-format-code nil t)))
         (elpy-mode . flycheck-mode)
         (elpy-mode . common-prog)))
