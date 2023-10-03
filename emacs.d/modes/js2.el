(defun my-js-hook ()
  (my-common-prog)
  )

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook 'my-js-hook)
(setq js2-mode-show-strict-warnings nil)
