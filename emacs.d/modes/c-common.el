;; https://syamajala.github.io/c-ide.html

;; (defun my-flycheck-rtags-setup ()
;;   (require 'flycheck)
;;   (require 'rtags)

;;   (flycheck-select-checker 'rtags)
;;   (setq-local flycheck-highlighting-mode nil)
;;   (setq-local flycheck-check-syntax-automatically nil))


(defun my-c-mode-common-hook ()
  (my-common-prog)

  (require 'clang-format)
  (require 'cmake-ide)
  (require 'company-irony)
  (require 'company-irony-c-headers)
  (require 'company)
  (require 'company-rtags)
  ;; (require 'flycheck-rtags)
  (require 'irony)
  (require 'rtags)

  (add-hook 'before-save-hook (lambda () (when (memq major-mode '(c-mode c++-mode))
                                           (clang-format-buffer))))

  (setq rtags-completions-enabled t)
  (eval-after-load 'company
    '(add-to-list
      'company-backends 'company-rtags))
  (setq rtags-autostart-diagnostics t)
  (rtags-enable-standard-keybindings)

  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))

  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

  (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

  (setq company-backends (delete 'company-semantic company-backends))
  (eval-after-load 'company
    '(add-to-list
      'company-backends 'company-irony))

  (setq company-idle-delay 0)

  (eval-after-load 'company
    '(add-to-list
      'company-backends '(company-irony-c-headers company-irony)))

  (local-set-key (kbd "C-c d") 'rtags-find-symbol-at-point)
  (local-set-key (kbd "C-c r") 'rtags-find-references)

  (cmake-ide-setup)
  (irony-mode)
  (company-mode)
  ;; (flycheck-mode)
  ;; (my-flycheck-rtags-setup)
  (rtags-start-process-unless-running)
)

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; in emacs do after all:

;; 1. irony-install-server
;; 2. rtags-install
;;    If problem (from stackoverflow):
;;    "I've fixed issue just editing value of rtags-package-version to
;;    2.38 in rtags.el and M-x byte-recompile-directory. You need to
;;    make a new release in this repository"
