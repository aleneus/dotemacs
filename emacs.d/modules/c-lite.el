(require 'use-package)

(defun my-c-mode-hook ()
  (common-prog)

  (setq indent-tabs-mode nil)
  (setq tab-width 2))

(add-hook 'c-mode-common-hook 'my-c-mode-hook)
