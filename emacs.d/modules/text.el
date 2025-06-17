;; apt install aspell aspell-ru

(require 'flyspell)
(require 'flyspell-popup)

(defun my-text-hook ()
  (setq-default indent-tabs-mode t)
  (setq-default tab-width 4)
  (flyspell-mode))

(add-hook 'text-mode-hook 'my-text-hook)
