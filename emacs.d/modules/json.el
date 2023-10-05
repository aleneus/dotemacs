(defun my-json-mode-hook ()
  ;; NOTE: install jsonlint with apt
  (flycheck-mode)
  (hs-minor-mode)
  (setq json-mode-indent-level 4))

(add-hook 'json-mode-hook 'my-json-mode-hook)
