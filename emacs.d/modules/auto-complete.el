;; setups auto-complete and defines the function to switch on.

(require 'auto-complete)

(defun my-complete ()
  (setq ac-auto-start nil)
  (define-key ac-mode-map (kbd "M-<tab>") 'auto-complete)
  (define-key ac-mode-map (kbd "C-<space>") 'auto-complete)
  (setq ac-menu-height 30)

  (auto-complete-mode))
