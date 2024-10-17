;; sudo apt install jsonlint

(defun my-json-mode-hook ()
  (flycheck-mode)
  (hs-minor-mode)
  (setq json-mode-indent-level 4))

(add-hook 'json-mode-hook 'my-json-mode-hook)
