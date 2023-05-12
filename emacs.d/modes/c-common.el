(defun my-c-mode-common-hook ()
  (my-common-prog)

  ;; minimal
  (add-hook 'before-save-hook (lambda () (when (memq major-mode '(c-mode c++-mode))
                                           (clang-format-buffer))))

  (require 'highlight-doxygen)
  (highlight-doxygen-mode)

  ;; advanced
  (require 'clang-format)
  (require 'cmake-ide)
  (require 'company)
  (require 'flycheck)

  (add-to-list 'flycheck-disabled-checkers 'c/c++-clang)
  (flycheck-mode)

  (cmake-ide-setup)

  (setq company-idle-delay 0)
  (company-mode)
)

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
