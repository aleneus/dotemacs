(defun my-org-mode-hook ()
  (setq org-startup-folded t)
  (visual-line-mode))

(add-hook 'org-mode-hook 'my-org-mode-hook)
