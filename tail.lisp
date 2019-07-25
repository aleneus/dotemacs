;; do not create backup files
(setq make-backup-files nil)

;; display time
(display-time-mode 1)

;; snippets
;; install yasnipet before: M-x package-install 
;; (add-to-list 'load-path
;;               "~/.emacs.d/plugins/yasnippet")
;; (require 'yasnippet)
;; (yas-global-mode 1)

;; load hs-minor-mode in python-mode automatically
;(add-hook 'python-mode-hook 'hs-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; packages
;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keys
;; (global-set-key (kbd "C-j") 'backward-char)
;; (global-set-key (kbd "C-l") 'forward-char)
;; (global-set-key (kbd "C-k") 'forward-line)
;; (global-set-key (kbd "C-i") 'previous-line)
;; (global-set-key (kbd "C-M-l") 'forward-word)
;; (global-set-key (kbd "C-M-j") 'backward-word)

(global-set-key (kbd "C-'") 'comment-region)
(global-set-key (kbd "C-M-'") 'uncomment-region)

;; switching between windows
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;; bookmarks
(global-set-key [f5] 'bookmark-set)
(global-set-key [f6] 'bookmark-jump)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python
(defun my-python-hook ()
  (elpy-mode)
  (outline-minor-mode))

(add-hook 'python-mode-hook 'my-python-hook)
(add-hook 'python-mode-hook 'linum-mode)

;; elpy settings
(setq elpy-rpc-python-command "python3")
(global-set-key (kbd "C-c d") 'elpy-goto-definition)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; go
(defun my-go-hook ()
  (require 'company)
  (require 'flycheck)
  (require 'yasnippet)
  ;; (require 'go-eldoc)
  (require 'company-go)

  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (setq gofmt-args (list "-s"))
  (add-hook 'before-save-hook 'gofmt-before-save)

  (global-set-key [C-tab] (quote company-go))
)

(add-hook 'go-mode-hook 'my-go-hook)
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook 'linum-mode)
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))
(add-hook 'go-mode-hook 'yas-minor-mode)
(add-hook 'go-mode-hook 'hs-minor-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; neotree
(global-set-key [f9] 'neotree-toggle)
