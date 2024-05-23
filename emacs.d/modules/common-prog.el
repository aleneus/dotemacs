(require 'use-package)
(require 'flyspell)

;; flyspell-prog (for checking comments)
(defun my-flyspell-prog-hook ()
  (ispell-change-dictionary "english"))

(add-hook 'flyspell-prog-mode-hook 'my-flyspell-prog-hook)

;; fci
(use-package fill-column-indicator
  :ensure t
  :config
  (setq fci-rule-column 79)
  (setq fci-rule-width 3))

;; snippets
(use-package yasnippet
  :ensure t
  :config (yas-global-mode))

(defun common-prog ()
  (fci-mode)
  (add-hook 'before-save-hook 'whitespace-cleanup)
  (display-line-numbers-mode)

  (hs-minor-mode)
  (global-set-key (kbd "<C-tab>") 'hs-toggle-hiding)

  (flyspell-prog-mode)
  (my-complete))
