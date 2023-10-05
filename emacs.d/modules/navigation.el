(require 'ls-lisp)
(setq ls-lisp-dirs-first t)
(setq ls-lisp-use-insert-directory-program nil)

(require 'dired-subtree)

(use-package dired
  :bind (:map dired-mode-map
              ("<tab>" . dired-subtree-toggle)))

(put 'dired-find-alternate-file 'disabled nil)
