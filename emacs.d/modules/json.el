;; sudo apt install jsonlint

(defun my-json-mode-hook ()
  (flycheck-mode)
  (hs-minor-mode)
  (setq json-mode-indent-level 4)
  (global-set-key (kbd "<C-tab>") 'hs-toggle-hiding))

(add-hook 'json-mode-hook 'my-json-mode-hook)

(use-package json-mode
  :ensure t
  :hook
  (json-mode . my-json-mode-hook))
