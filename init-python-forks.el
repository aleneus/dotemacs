;;
;; Python for third-party projects
;;

;; transparency
(set-frame-parameter (selected-frame) 'alpha '(95 . 90))
(add-to-list 'default-frame-alist '(alpha . (95 . 90)))

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

;; popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

;; buffer list
(push '("*Buffer List*" :regexp t :position right :width 0.4 :dedicated t :stick t)
      popwin:special-display-config)

;; file navigation
(require 'direx)
(push '(direx:direx-mode :position left :width 40 :dedicated t)
      popwin:special-display-config)
(global-set-key [f9] 'direx:jump-to-directory-other-window)

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

;; company
(require 'company)

;; find file at point
(ffap-bindings)

;; insert time
(defun now ()
  "Insert string for the current time formatted like '2:34 PM'."
  (interactive)
  (insert (format-time-string "%D %-I:%M %p")))

;;
;; mode hooks

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

;; common for programming modes
(defun my-common-prog ()
  (require 'hl-fill-column)
  (require 'fill-column-indicator)

  (add-hook 'before-save-hook 'whitespace-cleanup)
  (linum-mode)
  (fci-mode)
  (setq fci-rule-column 79)
  (flyspell-prog-mode)
  (hs-minor-mode))

;; flyspell-prog (for checking comments)
(defun my-flyspell-prog-hook ()
  (ispell-change-dictionary "english"))

(add-hook 'flyspell-prog-mode-hook 'my-flyspell-prog-hook)

;; python-mode
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

  (outline-minor-mode)
  (flycheck-mode)

  (global-set-key (kbd "C-c d") 'elpy-goto-definition)
  (jedi-mode)

  ;; running tests
  ;; sudo pip3 install pytest
  (require 'py-test)
)

(add-hook 'python-mode-hook 'my-python-hook)


;; makdown-mode
(defun my-markdown-mode-hook ()
  (visual-line-mode))

(add-hook 'markdown-mode-hook 'my-markdown-mode-hook)

;; restructured text
(defun my-rst-mode-hook ()
  (visual-line-mode))

(add-hook 'rst-mode-hook 'my-rst-mode-hook)

;;
;; json-mode

(defun my-json-mode-hook ()
  ;; NOTE: install jsonlint with apt
  (flycheck-mode)
  (hs-minor-mode))

(add-hook 'json-mode-hook #'flycheck-mode)
(add-hook 'json-mode-hook 'my-json-mode-hook)
