(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/org-roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))

(defun my-org-roam-mode-hook ()
  (org-roam-db-autosync-mode))

(add-hook 'org-roam-mode-hook 'my-org-roam-mode-hook)
