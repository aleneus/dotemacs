;; apt install aspell aspell-ru

(require 'flyspell)
(require 'flyspell-popup)

(defun my-text-hook ()
  (setq indent-tabs-mode nil)
  (flyspell-mode)
  (my-complete))

(add-hook 'text-mode-hook 'my-text-hook)
