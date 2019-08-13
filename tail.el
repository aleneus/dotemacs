;; do not create backup files
(setq make-backup-files nil)

;; display time
(display-time-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;; translate
(require 'google-translate)
(global-set-key (kbd "C-c g") 'google-translate-at-point)

;; spell checking
(global-set-key
 (kbd "C-c l e")
 (lambda()
   (interactive)
   (ispell-change-dictionary "english")))

(global-set-key
 (kbd "C-c l r")
 (lambda ()
   (interactive)
   (ispell-change-dictionary "russian")))

;; navigarion
(require 'neotree)
(global-set-key [f9] 'neotree-toggle)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; highlighting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; current line
(global-hl-line-mode 1)
(set-face-background 'highlight "#222")
(set-face-foreground 'highlight nil)
;; brackets
(show-paren-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; different modes settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; python
(defun my-python-hook ()
  (elpy-mode)
  (outline-minor-mode))

(add-hook 'python-mode-hook 'my-python-hook)
(add-hook 'python-mode-hook 'linum-mode)

(setq elpy-rpc-python-command "python3")
(global-set-key (kbd "C-c d") 'elpy-goto-definition)


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

;; latex
(require 'auctex)
(require 'company-auctex)
(add-to-list 'auto-mode-alist '("\\.tex\\'" . LaTeX-mode))

(defun my-latex-hook ()
  (setq TeX-parse-self t)
  (visual-line-mode)
  (flyspell-mode 1))

(add-hook 'LaTeX-mode-hook 'my-latex-hook)
