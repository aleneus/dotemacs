(global-set-key (kbd "C-h") 'replace-string)
(global-set-key (kbd "C-'") 'comment-region)
(global-set-key (kbd "C-M-'") 'uncomment-region)
(global-set-key [f3] 'kmacro-start-macro)
(global-set-key [f4] 'kmacro-end-macro)
(global-set-key [f5] 'call-last-kbd-macro)

;; highlight brackets
(show-paren-mode 1)

;; highlight current line
(global-hl-line-mode 1)
(set-face-background 'highlight "#303030")
(set-face-foreground 'highlight nil)

;; scroll
(require 'smooth-scrolling)
(smooth-scrolling-mode)

;; prefer spaces by default
(setq-default indent-tabs-mode nil)
