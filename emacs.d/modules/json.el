;; sudo apt install jsonlint
(require 'json-mode)

(defun my-json-mode-hook ()
  (flycheck-mode)
  (hs-minor-mode)
  (setq json-mode-indent-level 4)
  (global-set-key (kbd "<C-tab>") 'hs-toggle-hiding))

(add-hook 'json-mode-hook 'my-json-mode-hook)
