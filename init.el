;; for emacs >= 26

;; put copy of this file to .emacs.d

;; prefer spaces by default
(setq-default indent-tabs-mode nil)

;; hide welcome screen
(setq inhibit-splash-screen t)

;; add custom file for customization interface
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; packages
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;; uncomment next line if there is a problem with GPG
(setq package-check-signature nil)

;; count lines
(require 'total-lines)

(global-total-lines-mode 1)

(defun total-lines-count ()
  "Print the total number of lines"
  (interactive)
  (message "%d" total-lines))

(global-set-key (kbd "C-c C-t") 'total-lines-count)

;; replace-string
(global-set-key (kbd "C-h") 'replace-string)

;; comments
(global-set-key (kbd "C-'") 'comment-region)
(global-set-key (kbd "C-M-'") 'uncomment-region)

;; switching between windows
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)

;; rgrep
(global-set-key (kbd "C-x C-g") 'rgrep)

;; file navigation
(require 'neotree)
(global-set-key [f9] 'neotree-toggle)
(setq neo-window-height 20)
(setq neo-window-position 'left)

;; macro
(global-set-key [f3] 'kmacro-start-macro)
(global-set-key [f4] 'kmacro-end-macro)
(global-set-key [f5] 'call-last-kbd-macro)

;; popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;; buffer list
(push '("*Buffer List*" :regexp t :position right :width 0.4 :dedicated t :stick t)
      popwin:special-display-config)

;;
;; close-display-connection
(global-set-key [f10] 'close-display-connection)

;; editing
(require 'iedit)
(global-set-key (kbd "C-:") 'iedit-mode)

(require 'multiple-cursors)
(global-set-key (kbd "C-c m c") 'mc/edit-lines)

;; umlauts
(define-key key-translation-map (kbd "<f8> u") (kbd "ü"))
(define-key key-translation-map (kbd "<f8> U") (kbd "Ü"))
(define-key key-translation-map (kbd "<f8> o") (kbd "ö"))
(define-key key-translation-map (kbd "<f8> O") (kbd "Ö"))
(define-key key-translation-map (kbd "<f8> a") (kbd "ä"))
(define-key key-translation-map (kbd "<f8> A") (kbd "Ä"))
(define-key key-translation-map (kbd "<f8> s") (kbd "ß"))

;; highlight current line
(global-hl-line-mode 1)
(set-face-background 'highlight "#222")
(set-face-foreground 'highlight nil)

;; highlight brackets
(show-paren-mode 1)

;; do not create backup files
(setq make-backup-files nil)

;; display time
(display-time-mode 1)

;; alarm
(require 'alarm-clock)
(global-set-key (kbd "C-x C-a") 'alarm-clock-set)

;; common flyspell
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

;;
;; different modes

;; common for programming modes
(require 'hl-fill-column)
(require 'fill-column-indicator)

(defun my-common-prog ()
  (add-hook 'before-save-hook 'whitespace-cleanup)
  (linum-mode)
  (fci-mode)
  (flyspell-prog-mode))

;; flyspell-prog (for checking comments)
(defun my-flyspell-prog-hook ()
  (ispell-change-dictionary "english"))

(add-hook 'flyspell-prog-mode-hook 'my-flyspell-prog-hook)

;; c-mode
(defun my-c-hook ()
  (my-common-prog)
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (setq indent-tabs-mode t))

(add-hook 'c-mode-hook 'my-c-hook)

;; python-mode
(require 'flycheck)
(require 'elpy)

(defun my-python-hook ()
  (my-common-prog)

  ;; code navigation
  (push '("*Occur*" :regexp t :position right :width 0.4 :dedicated t :stick t)
        popwin:special-display-config)

  (setq tab-width 4)
  (setq indent-tabs-mode nil)

  (setq elpy-rpc-python-command "python3")

  (setq flycheck-checker 'python-pylint)

  (elpy-enable)
  (elpy-mode)
  (outline-minor-mode)
  (flycheck-mode)

  (global-set-key (kbd "C-c d") 'elpy-goto-definition)
  (jedi-mode))

(add-hook 'python-mode-hook 'my-python-hook)

;; java-mode
(defun my-java-hook ()
  (my-common-prog)
  (hs-minor-mode))

(add-hook 'java-mode-hook 'my-java-hook)

;; go-mode
(require 'lsp-mode)
(require 'flycheck)
(require 'yasnippet)
(require 'go-mode)
(require 'gotest)
(require 'flycheck-golangci-lint)
(require 'go-snippets)
(require 'go-eldoc)
(require 'go-direx)
(require 'godoctor)

;; based on:
;; http://reangdblog.blogspot.com/2016/06/emacs-ide-go.html

;; export PATH=$PATH:$(go env GOPATH)/bin

;; go get -u -v github.com/rogpeppe/godef
;; go get -u -v golang.org/x/tools/cmd/guru
;; go get -u -v golang.org/x/tools/cmd/gorename
;; go get -u -v golang.org/x/tools/cmd/goimports
;; go get -u -v golang.org/x/lint/golint
;; go get -u -v github.com/kisielk/errcheck
;; go get -u -v github.com/jstemmer/gotags
;; go get -u -v github.com/godoctor/godoctor
;; sudo go get -u -v golang.org/x/tools/cmd/godoc

(defun my-go-hook ()
  (my-common-prog)

  (setq tab-width 4)
  (setq indent-tabs-mode t)

  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t)

  (global-set-key (kbd "C-c t") 'go-test-current-test)
  (global-set-key (kbd "C-c f") 'go-test-current-file)
  (global-set-key (kbd "C-c d") 'godef-jump)

  (flycheck-mode)
  (setq-default flycheck-disabled-checkers '(go-vet))

  (define-key go-mode-map [f11] 'go-direx-pop-to-buffer)
  (push '("^\*go-direx:" :regexp t :position right :width 0.4 :dedicated t :stick t)
        popwin:special-display-config)

  (yas-minor-mode)
  (hs-minor-mode)
  (go-eldoc-setup)
  (lsp-deferred))

(add-hook 'go-mode-hook 'my-go-hook)

;; emacs-lisp-mode
(defun my-emacs-lisp-hook ()
  (my-common-prog)
)

(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-hook)

;; latex-mode
(require 'company-auctex)

(add-to-list 'auto-mode-alist '("\\.tex\\'" . LaTeX-mode))

(defun my-latex-hook ()
  (setq TeX-parse-self t)
  (visual-line-mode)
  (company-mode)
  (flyspell-mode))

(add-hook 'LaTeX-mode-hook 'my-latex-hook)

;; json-mode
(defun my-json-hook ()
  (setq indent-tabs-mode nil))

(add-hook 'json-mode-hook 'my-json-hook)

;; text-mode
(defun my-text-hook ()
  (setq indent-tabs-mode nil))

(add-hook 'text-mode-hook 'my-text-hook)

;; graphviz-dot-mode
(require 'graphviz-dot-mode)
(defun my-graphviz-dot-mode-hook ()
  (setq graphviz-dot-indent-width 4))

(add-hook 'graphviz-dot-mode-hook 'my-graphviz-dot-mode-hook)

;; sh-mode
(defun my-sh-mode-hook ()
  (my-common-prog))

(add-hook 'sh-mode-hook 'my-sh-mode-hook)

;; makdown-mode
(require 'markdown-mode)

(defun my-markdown-mode-hook ()
  (visual-line-mode))

(add-hook 'markdown-mode-hook 'my-markdown-mode-hook)

;;
;; restructured text
(defun my-rst-mode-hook ()
  (visual-line-mode))

(add-hook 'rst-mode-hook 'my-rst-mode-hook)

;;
;; feature-mode
(require 'feature-mode)

(defun my-feature-mode-hook ()
  (my-common-prog))

(add-hook 'feature-mode-hook 'my-feature-mode-hook)

;;
;; terminal
(require 'terminal-toggle)
(setq terminal-toggle--term-shell "/bin/bash")
(setq terminal-toggle--term-title "myterm")

(defun my-set-term-font ()
  "Set font for terminal buffer"
  (setq buffer-face-mode-face '(:height 180))
  (buffer-face-mode))

(defun my-terminal-toggle ()
  "Toggle terminal window"
  (interactive)
  (terminal-toggle)
  (when (string= (buffer-name) "*myterm*") (my-set-term-font)))

(global-set-key (kbd "C-x t") 'my-terminal-toggle)

;;
;; javascript-mode
(defun my-javascript-hook ()
  (my-common-prog)
  (setq tab-width 8)
  (setq javascript-indent-level 2)
  (setq indent-tabs-mode nil))

(add-hook 'javascript-mode-hook 'my-javascript-hook)

;;
;; json-mode
(require 'json-mode)
