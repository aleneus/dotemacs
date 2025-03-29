(defun my-python-mode-hook ()
  (common-prog))

(add-hook 'python-mode-hook 'my-python-mode-hook)
(add-hook 'before-save-hook 'yapfify-buffer)
