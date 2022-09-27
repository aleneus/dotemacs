;; hide welcome screen
(setq inhibit-splash-screen t)

;; do not create backup files
(setq make-backup-files nil)

;; add custom file for customization interface
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; packages
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;; uncomment next line if there is a problem with GPG
;; (setq package-check-signature nil)

;; transparency
(set-frame-parameter (selected-frame) 'alpha '(95 . 90))
(add-to-list 'default-frame-alist '(alpha . (95 . 90)))

;; highlight current line
(global-hl-line-mode 1)
(set-face-background 'highlight "#222")
(set-face-foreground 'highlight nil)

;; highlight brackets
(show-paren-mode 1)

;; display time
(display-time-mode 1)

;; prefer spaces by default
(setq-default indent-tabs-mode nil)

;; replace-string
(global-set-key (kbd "C-h") 'replace-string)

;; comments
(global-set-key (kbd "C-'") 'comment-region)
(global-set-key (kbd "C-M-'") 'uncomment-region)

;; rgrep
(global-set-key (kbd "C-x C-g") 'rgrep)

;; macro
(global-set-key [f3] 'kmacro-start-macro)
(global-set-key [f4] 'kmacro-end-macro)
(global-set-key [f5] 'call-last-kbd-macro)

;; pretty show modes
(require 'mode-icons)
(mode-icons-mode)

;; find file at point
(ffap-bindings)

(defvar ffap-file-at-point-line-number nil
  "Variable to hold line number from the last `ffap-file-at-point' call.")

(defadvice ffap-file-at-point (after ffap-store-line-number activate)
  "Search `ffap-string-at-point' for a line number pattern and save it
in `ffap-file-at-point-line-number' variable."
  (let* ((string (ffap-string-at-point))
         (name
          (or (condition-case nil
                  (and (not (string-match "//" string))
                       (substitute-in-file-name string))
                (error nil))
              string))
         (line-number-string
          (and (string-match ":[0-9]+" name)
               (substring name (1+ (match-beginning 0)) (match-end 0))))
         (line-number
          (and line-number-string
               (string-to-number line-number-string))))
    (if (and line-number (> line-number 0))
        (setq ffap-file-at-point-line-number line-number)
      (setq ffap-file-at-point-line-number nil))))

(defadvice find-file-at-point (after ffap-goto-line-number activate)
  "If `ffap-file-at-point-line-number' is non-nil goto this line."
  (when ffap-file-at-point-line-number
    (funcall-interactively #'goto-line ffap-file-at-point-line-number)
    (setq ffap-file-at-point-line-number nil)))


(require 'use-package)

;; popwin
(use-package popwin
  :init
  (setq display-buffer-function 'popwin:display-buffer))

;; iedit
(use-package iedit
  :init (global-set-key (kbd "C-:") 'iedit-mode))

;; multiple-cursors
(use-package multiple-cursors
  :init (global-set-key (kbd "C-c m c") 'mc/edit-lines))

;; file navigation
(require 'direx)
(push '(direx:direx-mode :position left :width 40 :dedicated t)
      popwin:special-display-config)
(global-set-key [f9] 'direx:jump-to-directory-other-window)

;; company
(require 'company)

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

;; common for programming modes
(defun my-common-prog ()
  (require 'hl-fill-column)
  (require 'fill-column-indicator)

  (add-hook 'before-save-hook 'whitespace-cleanup)
  (linum-mode)
  (fci-mode)
  (setq fci-rule-column 79)
  (flyspell-prog-mode)

  (hs-minor-mode)
  (global-set-key (kbd "<C-tab>") 'hs-toggle-hiding)

  ;; (require 'minimap)
  ;; (setq minimap-window-location (quote right))
  ;; (minimap-mode)
)

;; go
(use-package go-mode
  ;; add to .profile:
  ;; export PATH=$PATH:$(go env GOPATH)/bin

  ;; Required tools:

  ;; github.com/rogpeppe/godef
  ;; golang.org/x/tools/gopls
  ;; github.com/golangci/golangci-lint/cmd/golangci-lint
  ;; github.com/jstemmer/gotags

  :config
  (require 'lsp-mode)
  (require 'lsp-ui)
  (require 'flycheck)
  (require 'yasnippet)
  (require 'gotest)
  (require 'go-snippets)
  (require 'go-eldoc)
  (require 'go-direx)
  (require 'godoctor)

  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t)

  :bind
  ("C-c t" . go-test-current-test)
  ("C-c f" . go-test-current-file)
  ("C-c d" . godef-jump)
  ([f11] . go-direx-pop-to-buffer)

  :hook
  (go-mode . (lambda ()
               (setq tab-width 4)
               (setq indent-tabs-mode t)
               (setq-default flycheck-disabled-checkers '(go-vet))

               (go-mode . my-common-prog)
               (go-mode . flycheck-mode)
               (go-mode . yas-minor-mode)
               (go-mode . go-eldoc-setup)
               (go-mode . lsp-deferred))))

;; c
(defun my-c-hook ()
  (my-common-prog)
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (setq indent-tabs-mode t))

(add-hook 'c-mode-hook 'my-c-hook)

;; python
(defun my-python-hook ()
  (require 'flycheck)
  (require 'elpy)
  (require 'jedi)

  (my-common-prog)

  ;; code navigation
  (push '("*Occur*" :regexp t :position right :width 0.4 :dedicated t :stick t)
        popwin:special-display-config)

  (setq tab-width 4)
  (setq indent-tabs-mode nil)

  (setq elpy-rpc-python-command "python3")
  (setq elpy-rpc-backend "jedi")
  (setq elpy-rpc-virtualenv-path 'current)

  (setq flycheck-checker 'python-pylint)

  (elpy-enable)
  (elpy-mode)

  (flycheck-mode)

  (global-set-key (kbd "C-c d") 'elpy-goto-definition)
  (jedi-mode)

  ;; running tests
  ;; sudo pip3 install pytest
  (require 'py-test)

  ;; format-code
  (require 'py-yapf)
  (py-yapf-enable-on-save))

(add-hook 'python-mode-hook 'my-python-hook)

;; java
(defun my-java-hook ()
  (my-common-prog))

(add-hook 'java-mode-hook 'my-java-hook)

;; emacs-lisp
(defun my-emacs-lisp-hook ()
  (my-common-prog))

(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-hook)

;; latex
(add-to-list 'auto-mode-alist '("\\.tex\\'" . LaTeX-mode))

(defun my-latex-hook ()
  (require 'company-auctex)

  (setq TeX-parse-self t)
  (visual-line-mode)
  (company-mode)
  (flyspell-mode))

(add-hook 'LaTeX-mode-hook 'my-latex-hook)

;; text
(defun my-text-hook ()
  (setq indent-tabs-mode nil))

(add-hook 'text-mode-hook 'my-text-hook)

;; graphviz-dot
(defun my-graphviz-dot-mode-hook ()
  (require 'graphviz-dot-mode)
  (setq graphviz-dot-indent-width 4))

(add-hook 'graphviz-dot-mode-hook 'my-graphviz-dot-mode-hook)

;; sh
(defun my-sh-mode-hook ()
  (my-common-prog))

(add-hook 'sh-mode-hook 'my-sh-mode-hook)

;; markdown
(defun my-markdown-mode-hook ()
  (visual-line-mode))

(add-hook 'markdown-mode-hook 'my-markdown-mode-hook)

;; rst
(defun my-rst-mode-hook ()
  (visual-line-mode))

(add-hook 'rst-mode-hook 'my-rst-mode-hook)

;; gherkin
(defun my-feature-mode-hook ()
  (my-common-prog))

(add-hook 'feature-mode-hook 'my-feature-mode-hook)

;; js
(defun my-js-hook ()
  ;; NOTE: install npm: https://losst.ru/ustanovka-node-js-ubuntu-18-04
  ;; NOTE: install tern: sudo npm install -g tern

  (require 'js2-mode)
  (require 'json-mode)
  (require 'js2-refactor)
  (require 'xref-js2)
  (require 'ag)
  (require 'ac-js2)
  (require 'coffee-mode)
  (require 'tern)
  (require 'tern-auto-complete)

  (my-common-prog)

  (eval-after-load 'tern
    '(progn
       (tern-ac-setup)))

  (tern-mode)
  (auto-complete-mode))

(add-hook 'js2-mode-hook 'my-js-hook)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'company-backends 'ac-js2-company)

(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
(add-hook 'js2-mode-hook #'js2-refactor-mode)

(add-hook 'js2-mode-hook (lambda ()
  (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

;; json
(defun my-json-mode-hook ()
  ;; NOTE: install jsonlint with apt
  (flycheck-mode)
  (hs-minor-mode))

(add-hook 'json-mode-hook #'flycheck-mode)
(add-hook 'json-mode-hook 'my-json-mode-hook)
