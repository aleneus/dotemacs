;; sideline

(require 'sideline-flycheck)
(require 'sideline-lsp)
(require 'sideline)
(require 'use-package)

(use-package sideline
  :init
  (setq sideline-backends-left-skip-current-line t
        sideline-backends-right-skip-current-line t
        sideline-order-left 'down
        sideline-order-right 'up
        sideline-format-left "%s   "
        sideline-format-right "   %s"
        sideline-priority 100
        sideline-display-backend-name t)

  (setq sideline-backends-right '((sideline-lsp      . up)
                                  (sideline-flycheck . down))))

(use-package sideline-flycheck
  :init
  (setq sideline-backends-right '(sideline-flycheck))

  :hook ((flycheck-mode . sideline-mode)
         (flycheck-mode . sideline-flycheck-setup)))

(use-package sideline-lsp
  :init
  (setq sideline-backends-right '(sideline-lsp)))


(use-package lsp-ui
  :init (setq lsp-ui-sideline-enable nil))
