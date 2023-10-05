(require 'use-package)

;; flyspell-prog (for checking comments)
(defun my-flyspell-prog-hook ()
  (ispell-change-dictionary "english"))

(add-hook 'flyspell-prog-mode-hook 'my-flyspell-prog-hook)

;; fci
(use-package fill-column-indicator
  :ensure t
  :config (setq fci-rule-column 79))

;; snippets
(use-package yasnippet
  :ensure t
  :config (yas-global-mode))

(defun my-common-prog ()
  (add-hook 'before-save-hook 'whitespace-cleanup)
  (linum-mode)
  (fci-mode)

  (hs-minor-mode)
  (global-set-key (kbd "<C-tab>") 'hs-toggle-hiding)

  (flyspell-prog-mode)
)
