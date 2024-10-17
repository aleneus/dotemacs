;; apt install aspell aspell-ru

(require 'flyspell)
(require 'flyspell-popup)
(require 'writegood-mode)

(defun my-markdown-mode-hook ()
  (visual-line-mode)
  (flyspell-mode)
  (writegood-mode))

(add-hook 'markdown-mode-hook 'my-markdown-mode-hook)
