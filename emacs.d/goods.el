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
(require 'direx)

(push '(direx:direx-mode :position left :width 40 :dedicated t)
      popwin:special-display-config)
(global-set-key [f9] 'direx:jump-to-directory-other-window)
