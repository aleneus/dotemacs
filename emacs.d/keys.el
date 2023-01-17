;; key bindings

(global-set-key (kbd "C-h") 'replace-string)
(global-set-key (kbd "C-'") 'comment-region)
(global-set-key (kbd "C-M-'") 'uncomment-region)
(global-set-key (kbd "C-x C-g") 'rgrep)
(global-set-key [f3] 'kmacro-start-macro)
(global-set-key [f4] 'kmacro-end-macro)
(global-set-key [f5] 'call-last-kbd-macro)
(global-set-key (kbd "C-c o") 'occur)
