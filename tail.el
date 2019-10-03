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

;; common for programming modes
(defun my-common-prog ()
  (require 'hl-fill-column)
  (require 'fill-column-indicator)
  ;; (require 'flyspell)
  
  (linum-mode)
  (fci-mode)
  (flyspell-prog-mode))

;; c
(defun my-c-hook ()
  (my-common-prog)
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (setq indent-tabs-mode t))

(add-hook 'c-mode-hook 'my-c-hook)

;; python
(defun my-python-hook ()
  (my-common-prog)
  (require 'flycheck)
  (require 'company-jedi)

  (setq tab-width 4)
  (setq indent-tabs-mode nil)

  (setq elpy-rpc-python-command "python3")
  (global-set-key (kbd "C-c d") 'elpy-goto-definition)

  (lambda ()
    (set (make-local-variable 'company-backends) '(company-jedi))
    (company-mode))

  (setq flycheck-checker 'python-pylint)

  (elpy-mode)
  (outline-minor-mode)
  (flycheck-mode))

(add-hook 'python-mode-hook 'my-python-hook)

;; go
(require 'go-mode)
;; based on:
;; http://reangdblog.blogspot.com/2016/06/emacs-ide-go.html

(defun my-go-hook ()
  (my-common-prog)

  ;; export PATH=$PATH:$(go env GOPATH)/bin
  ;; sudo go get -u github.com/nsf/gocode
  ;; sudo go get -u github.com/rogpeppe/godef
  ;; sudo go get -u golang.org/x/tools/cmd/guru
  ;; sudo go get -u golang.org/x/tools/cmd/gorename
  ;; sudo go get -u golang.org/x/tools/cmd/goimports
  
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (setq gofmt-args (list "-s"))
  (add-hook 'before-save-hook 'gofmt-before-save)

  (require 'gotest)
  (global-set-key (kbd "C-c C-t") 'go-test-current-test)

  (require 'company)
  (require 'company-go)
  (set (make-local-variable 'company-backends) '(company-go))
  (company-mode)

  (require 'flycheck)
  (flycheck-mode)
 
  (require 'flycheck-golangci-lint) ;; go get -u golang.org/x/lint/golint
                                    ;; go get -u github.com/kisielk/errcheck
  (require 'yasnippet)
  (require 'go-snippets)
  (require 'go-eldoc) ;; sudo go get -u golang.org/x/tools/cmd/godoc
  (require 'go-direx) ;; go get -u github.com/jstemmer/gotags
  (require 'godoctor) ;; go get github.com/godoctor/godoctor

  ;; (global-set-key [C-tab] (quote company-go))
  (global-set-key [f11] 'go-direx-switch-to-buffer)

  (yas-minor-mode)
  (hs-minor-mode)
  (go-eldoc-setup))

(add-hook 'go-mode-hook 'my-go-hook)

;; latex
(add-to-list 'auto-mode-alist '("\\.tex\\'" . LaTeX-mode))

(defun my-latex-hook ()
  (require 'company-auctex)

  (setq TeX-parse-self t)
  (visual-line-mode)
  (company-mode)
  (flyspell-mode))

(add-hook 'LaTeX-mode-hook 'my-latex-hook)

;; flyspell
(defun my-flyspell-hook ()
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
     (ispell-change-dictionary "russian"))))

(add-hook 'flyspell-mode-hook 'my-flyspell-hook)

;; flyspell-prog (for checking comments)
(defun my-flyspell-prog-hook ()
  (ispell-change-dictionary "english"))

(add-hook 'flyspell-prog-mode-hook 'my-flyspell-prog-hook)

;; refactoring
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

(global-set-key [f12] 'duplicate-current-line-or-region)
