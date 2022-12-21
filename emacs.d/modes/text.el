(defun my-text-hook ()
  (setq indent-tabs-mode nil))

(add-hook 'text-mode-hook 'my-text-hook)
