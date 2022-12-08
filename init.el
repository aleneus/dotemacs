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

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("gnu-devel" . "https://elpa.gnu.org/devel/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)
;; uncomment next line if there is a problem with GPG
;; (setq package-check-signature nil)

(require 'use-package)

;; colors
(require 'django-theme)
(load-theme 'django)

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

;; key bindings
(global-set-key (kbd "C-h") 'replace-string)
(global-set-key (kbd "C-'") 'comment-region)
(global-set-key (kbd "C-M-'") 'uncomment-region)
(global-set-key (kbd "C-x C-g") 'rgrep)
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

;; popwin
(use-package popwin
  :init (setq display-buffer-function 'popwin:display-buffer))

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

;; fci
(use-package fill-column-indicator
  :config (setq fci-rule-column 79))

;; common for programming modes
(defun my-common-prog ()
  (add-hook 'before-save-hook 'whitespace-cleanup)
  (linum-mode)
  (fci-mode)

  (hs-minor-mode)
  (global-set-key (kbd "<C-tab>") 'hs-toggle-hiding)

  (flyspell-prog-mode)
)

;; snippets
(use-package yasnippet
  :ensure t
  :config (yas-global-mode))

;; C++
;; sudo apt install rtags
;; sudo apt install clang
;; sudo apt install libclang-dev

(add-hook 'c-mode-common-hook 'my-common-prog)

(require 'rtags)

(setq rtags-completions-enabled t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)

(require 'irony)
(add-hook 'c-mode-common-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(require 'company-irony)

(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq company-backends (delete 'company-semantic company-backends))
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-irony))

(setq company-idle-delay 0)
;; (define-key c-mode-map [(tab)] 'company-complete)
;; (define-key c++-mode-map [(tab)] 'company-complete)

(require 'company-irony-c-headers)

(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

(add-hook 'c-mode-common-hook 'company-mode)
(add-hook 'c-mode-common-hook 'flycheck-mode)

(require 'flycheck-rtags)

(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil)
  (setq-local flycheck-check-syntax-automatically nil))

(add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)

(require 'clang-format)
(add-hook 'before-save-hook (lambda () (when (memq major-mode '(c-mode c++-mode))
                                         (clang-format-buffer))))

(require 'cmake-ide)
(cmake-ide-setup)

;; emacs-lisp
(defun my-emacs-lisp-hook ()
  (my-common-prog))

(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-hook)

;; Go
(use-package go-mode
  ;; add to .profile:
  ;; export PATH=$PATH:$(go env GOPATH)/bin
  :config
  (require 'flycheck)
  (require 'lsp-mode)
  (require 'lsp-ui)
  (require 'gotest)
  (require 'go-snippets)
  (require 'go-eldoc)
  (require 'go-direx)
  (require 'godoctor)

  :bind
  (:map go-mode-map
        ("C-c t" . go-test-current-test)
        ("C-c f" . go-test-current-file)
        ("C-c d" . godef-jump)
        ([f11] . go-direx-pop-to-buffer))

  :hook
  (go-mode
   . (lambda ()
       (my-common-prog)

       (setq tab-width 4)
       (setq indent-tabs-mode t)

       (add-hook 'before-save-hook #'lsp-format-buffer t t)
       (add-hook 'before-save-hook #'lsp-organize-imports t t)

       (setq-default flycheck-disabled-checkers '(go-vet))

       (flycheck-mode)
       (yas-minor-mode)
       (go-eldoc-setup)
       (lsp-deferred))))

;; python
(use-package python-mode
  ;; Install required tools:
  ;; sudo pip3 install pytest
  :config
  (require 'flycheck)
  (require 'elpy)
  (require 'jedi)
  (require 'py-test)
  (require 'py-yapf)

  :bind
  (:map python-mode-map
        ("C-c d" . elpy-goto-definition))

  :hook
  (python-mode
   . (lambda ()
       (setq tab-width 4)
       (setq indent-tabs-mode nil)
       (setq elpy-rpc-python-command "python3")
       (setq elpy-rpc-backend "jedi")
       (setq elpy-rpc-virtualenv-path 'current)
       (setq flycheck-checker 'python-pylint)

       (my-common-prog)
       (elpy-enable)
       (elpy-mode)
       (flycheck-mode)
       (jedi-mode)
       (py-yapf-enable-on-save))))

;; JSON files
(defun my-json-mode-hook ()
  ;; NOTE: install jsonlint with apt
  (flycheck-mode)
  (hs-minor-mode))

(add-hook 'json-mode-hook 'my-json-mode-hook)

;; java
(defun my-java-hook ()
  (my-common-prog))

(add-hook 'java-mode-hook 'my-java-hook)

;; LaTeX
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
