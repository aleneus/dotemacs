(require 'use-package)

(setq inhibit-splash-screen t)
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(use-package popwin
  :ensure t
  :init (setq display-buffer-function 'popwin:display-buffer))

(require 'smooth-scrolling)
(smooth-scrolling-mode)

(require 'mode-icons)
(mode-icons-mode)
