(require 'clang-format)
(require 'highlight-doxygen)
(require 'flycheck)

(defun my-c-mode-common-hook ()
  (common-prog)

  (highlight-doxygen-mode)

  (add-hook 'before-save-hook (lambda () (when (memq major-mode '(c-mode c++-mode))
                                           (clang-format-buffer))))

  ;; (add-to-list 'flycheck-disabled-checkers 'c/c++-clang)
  ;; (flycheck-mode)

  ;; (require 'company)
  ;; (setq company-idle-delay 0)
  ;; (company-mode)

  ;; ;; advanced
  ;; (require 'cmake-ide)
  ;; (require 'rtags) ;; apt get install rtags
  ;; (cmake-ide-setup)
)

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
