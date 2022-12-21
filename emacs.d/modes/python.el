(require 'use-package)

(use-package python-mode
  ;; Install required tools:
  ;; sudo pip3 install pytest
  :config
  (require 'elpy)
  (require 'flycheck)
  (require 'jedi)
  (require 'py-test)
  (require 'py-yapf)

  :bind
  (:map python-mode-map
        ("C-c d" . elpy-goto-definition))

  :hook
  (python-mode
   . (lambda ()
       (setq tab-width 4)
       (setq indent-tabs-mode nil)
       (setq elpy-rpc-python-command "python3")
       (setq elpy-rpc-backend "jedi")
       (setq elpy-rpc-virtualenv-path 'current)
       (setq flycheck-checker 'python-pylint)

       (my-common-prog)
       (elpy-enable)
       (elpy-mode)
       (flycheck-mode)
       (jedi-mode)
       (py-yapf-enable-on-save))))
