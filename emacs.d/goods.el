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
(require 'dired-sidebar)
(require 'vscode-icon)

(setq dired-sidebar-theme 'vscode)
(setq dired-listing-switches "-lXGh --group-directories-first")
(setq dired-sidebar-use-custom-font t)
(setq dired-sidebar-width 30)
(setq dired-sidebar-use-one-instance t)
(setq dired-sidebar-close-sidebar-on-file-open t)

(global-set-key [f9] 'dired-sidebar-toggle-sidebar)

;; dictionary
(use-package dictionary
  :ensure t
  :init (global-set-key [f6] 'dictionary-search))
