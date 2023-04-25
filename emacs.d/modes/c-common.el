(defun my-c-mode-common-hook ()
  (my-common-prog)

  (require 'flycheck)
  (require 'highlight-doxygen)
  (require 'clang-format)
  (require 'company)
  (require 'cmake-ide)

  (add-hook 'before-save-hook (lambda () (when (memq major-mode '(c-mode c++-mode))
                                           (clang-format-buffer))))
  (add-to-list 'flycheck-disabled-checkers 'c/c++-clang)
  (flycheck-mode)

  (setq company-idle-delay 0)

  (cmake-ide-setup)

  (company-mode)
  (highlight-doxygen-mode)
)

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
