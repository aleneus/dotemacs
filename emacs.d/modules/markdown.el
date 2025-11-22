;; apt install aspell aspell-ru

(use-package flyspell
  :ensure t)

(use-package flyspell-popup
  :ensure t)

(use-package writegood-mode
  :ensure t)

(defun my-markdown-mode-hook ()
  (visual-line-mode)
  (flyspell-mode)
  (writegood-mode))

(use-package markdown-mode
  :ensure t
  :hook
  (markdown-mode . my-markdown-mode-hook))
