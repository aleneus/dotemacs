(defun my-c-mode-common-hook ()
  (my-common-prog)

  (require 'clang-format)
  (require 'cmake-ide)
  (require 'company)
  (require 'company-rtags)
  (require 'rtags)

  (add-hook 'before-save-hook (lambda () (when (memq major-mode '(c-mode c++-mode))
                                           (clang-format-buffer))))

  (setq rtags-completions-enabled t)
  (eval-after-load 'company
    '(add-to-list
      'company-backends 'company-rtags))

  (local-set-key (kbd "C-c d") 'rtags-find-symbol-at-point)
  (local-set-key (kbd "C-c r") 'rtags-find-references)

  (cmake-ide-setup)
  (company-mode))

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; in emacs do after all:

;; 1. rtags-install
;;    If problem (from stackoverflow):
;;    "I've fixed issue just editing value of rtags-package-version to
;;    2.38 in rtags.el and M-x byte-recompile-directory. You need to
;;    make a new release in this repository"
