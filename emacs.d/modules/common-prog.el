(use-package flyspell
  :ensure t
  :hook (flyspell-prog-mode . (lambda ()
							   (ispell-change-dictionary "english")))

(use-package fill-column-indicator
  :ensure t
  :config
  (setq fci-rule-column 79)
  (setq fci-rule-width 3))

(use-package yasnippet
  :ensure t
  :config (yas-global-mode))

(defun common-prog ()
  (fci-mode)
  (add-hook 'before-save-hook 'whitespace-cleanup)
  (display-line-numbers-mode)

  (hs-minor-mode)
  (global-set-key (kbd "<C-tab>") 'hs-toggle-hiding)

  (flyspell-prog-mode))
