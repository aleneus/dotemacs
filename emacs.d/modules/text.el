(require 'flyspell)
(require 'flyspell-popup)

(defun my-text-hook ()
  (setq indent-tabs-mode nil)
  (flyspell-mode))

(add-hook 'text-mode-hook 'my-text-hook)
