;; fonts
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :slant normal :weight normal :height 200))))
 '(neo-dir-link-face ((t (:foreground "#73d216" :slant normal :weight bold :height 120 :family "Ubuntu Mono"))))
 '(neo-file-link-face ((t (:foreground "#eeeeec" :weight normal :height 120 :family "Ubuntu Mono"))))
 '(neo-root-dir-face ((t (:foreground "#eeeeec" :weight bold :height 120 :family " Ubuntu Mono")))))

;;
;; packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;; uncomment next line if there is a problem with GPG
(setq package-check-signature nil)

;;
;; count lines
(require 'total-lines)

(global-total-lines-mode 1)

(defun total-lines-count ()
  "Print the total number of lines"
  (interactive)
  (message "%d" total-lines))

(global-set-key (kbd "C-c C-t") 'total-lines-count)

;;
;; keys

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

;; term
(global-set-key (kbd "C-x t") 'term)

;; file navigation
(require 'neotree)
(global-set-key [f9] 'neotree-toggle)
(setq neo-window-width 20)
;; (setq neo-smart-open t)
;; uncomment next line to make window width changeable
;; (setq neo-window-fixed-size nil)

;; macro
(global-set-key [f3] 'kmacro-start-macro)
(global-set-key [f4] 'kmacro-end-macro)
(global-set-key [f5] 'call-last-kbd-macro)

;;
;; popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;;
;; buffer list
(push '("*Buffer List*" :regexp t :position right :width 0.4 :dedicated t :stick t)
      popwin:special-display-config)

;;
;; highlighting

;; current line
(global-hl-line-mode 1)
(set-face-background 'highlight "#222")
(set-face-foreground 'highlight nil)

;; brackets
(show-paren-mode 1)

;;
;; umlauts
(define-key key-translation-map (kbd "<f8> u") (kbd "ü"))
(define-key key-translation-map (kbd "<f8> U") (kbd "Ü"))
(define-key key-translation-map (kbd "<f8> o") (kbd "ö"))
(define-key key-translation-map (kbd "<f8> O") (kbd "Ö"))
(define-key key-translation-map (kbd "<f8> a") (kbd "ä"))
(define-key key-translation-map (kbd "<f8> A") (kbd "Ä"))
(define-key key-translation-map (kbd "<f8> s") (kbd "ß"))

;;
;; misc
(setq make-backup-files nil)
(display-time-mode 1)

;;
;; common for programming modes
(defun my-common-prog ()
  (add-hook 'before-save-hook 'whitespace-cleanup)

  (require 'hl-fill-column)
  (require 'fill-column-indicator)
  ;; (require 'flyspell)

  (linum-mode)
  (fci-mode)
  (flyspell-prog-mode))

;;
;; c-mode
(defun my-c-hook ()
  (my-common-prog)
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (setq indent-tabs-mode t))

(add-hook 'c-mode-hook 'my-c-hook)

;;
;; python-mode
(defun my-python-hook ()
  (my-common-prog)

  ;; code navigation
  (push '("*Occur*" :regexp t :position right :width 0.4 :dedicated t :stick t)
	popwin:special-display-config)

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

;;
;; java
(defun my-java-hook ()
  (my-common-prog)
  (hs-minor-mode))

(add-hook 'java-mode-hook 'my-java-hook)

;;
;; go-mode
(require 'go-mode)
;; based on:
;; http://reangdblog.blogspot.com/2016/06/emacs-ide-go.html

(defun my-go-hook ()
  (my-common-prog)

  ;; export PATH=$PATH:$(go env GOPATH)/bin
  ;; go get -u -v github.com/nsf/gocode
  ;; go get -u -v github.com/rogpeppe/godef
  ;; go get -u -v golang.org/x/tools/cmd/guru
  ;; go get -u -v golang.org/x/tools/cmd/gorename
  ;; go get -u -v golang.org/x/tools/cmd/goimports

  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (setq gofmt-args (list "-s"))
  (add-hook 'before-save-hook 'gofmt-before-save)

  (require 'gotest)
  (global-set-key (kbd "C-c t") 'go-test-current-test)
  (global-set-key (kbd "C-c f") 'go-test-current-file)

  (require 'company)
  (require 'company-go)
  (set (make-local-variable 'company-backends) '(company-go))
  (company-mode)

  (require 'flycheck)
  (flycheck-mode)
  (setq-default flycheck-disabled-checkers '(go-vet))
  (require 'flycheck-golangci-lint) ;; go get -u -v golang.org/x/lint/golint
				    ;; go get -u -v github.com/kisielk/errcheck
  (require 'yasnippet)
  (require 'go-snippets)
  (require 'go-eldoc) ;; sudo go get -u -v golang.org/x/tools/cmd/godoc

  (require 'go-direx) ;; go get -u -v github.com/jstemmer/gotags
  (define-key go-mode-map [f11] 'go-direx-pop-to-buffer)
  (push '("^\*go-direx:" :regexp t :position right :width 0.4 :dedicated t :stick t)
	popwin:special-display-config)

  ;; (global-set-key [C-tab] (quote company-go))

  (require 'godoctor) ;; go get -u -v github.com/godoctor/godoctor

  (yas-minor-mode)
  (hs-minor-mode)
  (go-eldoc-setup))

(add-hook 'go-mode-hook 'my-go-hook)
(add-hook 'go-mode-hook 'go-eldoc-setup)

;;
;; emacs-lisp-mode
(defun my-emacs-lisp-hook ()
  (my-common-prog)
)

(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-hook)

;;
;; latex-mode
(add-to-list 'auto-mode-alist '("\\.tex\\'" . LaTeX-mode))

(defun my-latex-hook ()
  (require 'company-auctex)

  (setq TeX-parse-self t)
  (visual-line-mode)
  (company-mode)
  (flyspell-mode))

(add-hook 'LaTeX-mode-hook 'my-latex-hook)

;;
;; json-mode
(defun my-json-hook ()
  (setq indent-tabs-mode nil))

(add-hook 'json-mode-hook 'my-json-hook)

;;
;; text-mode
(defun my-text-hook ()
  (setq indent-tabs-mode nil))

(add-hook 'text-mode-hook 'my-text-hook)

;;
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
;; flyspell-prog (for checking comments)
(defun my-flyspell-prog-hook ()
  (ispell-change-dictionary "english"))

(add-hook 'flyspell-prog-mode-hook 'my-flyspell-prog-hook)
