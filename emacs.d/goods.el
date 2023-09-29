(require 'use-package)

;; popwin
(use-package popwin
  :ensure t
  :init (setq display-buffer-function 'popwin:display-buffer))

;; iedit
(use-package iedit
  :ensure t
  :init (global-set-key (kbd "C-:") 'iedit-mode))

;; multiple-cursors
(use-package multiple-cursors
  :ensure t
  :init (global-set-key (kbd "C-c m c") 'mc/edit-lines))

;; file navigation
(require 'ls-lisp)
(setq ls-lisp-dirs-first t)
(setq ls-lisp-use-insert-directory-program nil)

(require 'dired-subtree)

(use-package dired
  :bind (:map dired-mode-map
              ("<tab>" . dired-subtree-toggle)))

;; dictionary
(use-package dictionary
  :ensure t
  :init (global-set-key [f6] 'dictionary-search))
