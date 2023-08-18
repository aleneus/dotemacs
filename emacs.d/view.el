;; transparency
;; (set-frame-parameter (selected-frame) 'alpha '(95 . 90))
;; (add-to-list 'default-frame-alist '(alpha . (95 . 90)))

;; highlight brackets
(show-paren-mode 1)

;; display time
(display-time-mode 1)

;; highlight current line
(global-hl-line-mode 1)
(set-face-background 'highlight "#303030")
(set-face-foreground 'highlight nil)

;; scroll
(require 'smooth-scrolling)
(smooth-scrolling-mode)

;; pretty show modes
(require 'mode-icons)
(mode-icons-mode)

;; prefer spaces by default
(setq-default indent-tabs-mode nil)
