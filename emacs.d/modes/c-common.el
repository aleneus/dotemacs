(defun my-c-mode-common-hook ()
  (my-common-prog)

  (require 'highlight-doxygen)
  (require 'clang-format)
  (require 'rtags)
  (require 'company)
  (require 'company-rtags)
  (require 'cmake-ide)

  (add-hook 'before-save-hook (lambda () (when (memq major-mode '(c-mode c++-mode))
                                           (clang-format-buffer))))

  ;; (setq rtags-autostart-diagnostics t)

  (setq rtags-completions-enabled t)
  (eval-after-load 'company
    '(add-to-list
      'company-backends 'company-rtags))
  (rtags-enable-standard-keybindings)

  (local-set-key (kbd "C-c d") 'rtags-find-symbol)
  (local-set-key (kbd "C-c r") 'rtags-find-references)

  ;; (my-flycheck-rtags-setup)
  ;; (flycheck-mode)

  (rtags-start-process-unless-running)

  (setq company-idle-delay 0)

  (cmake-ide-setup)

  (company-mode)
  (highlight-doxygen-mode)
)

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))


;; (defun my-flycheck-rtags-setup ()
;;   (require 'flycheck-rtags)

;;   "Configure flycheck-rtags for better experience."
;;   (flycheck-select-checker 'rtags)
;;   ;; (setq-local flycheck-check-syntax-automatically nil)
;;   ;; (setq-local flycheck-highlighting-mode nil)
;;   )

;; (add-hook 'c-mode-hook #'my-flycheck-rtags-setup)
;; (add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)
