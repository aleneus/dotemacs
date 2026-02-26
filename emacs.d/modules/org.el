(defun my-org-mode-hook ()
  (setq org-startup-folded t)
  (setq org-log-done 'time)
  (visual-line-mode))

(add-hook 'org-mode-hook 'my-org-mode-hook)
