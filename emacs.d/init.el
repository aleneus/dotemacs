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
        ("melpa" . "https://melpa.org/packages/")
        ("elpa_local" . "/home/apopov/emacs-pkgs/elpa")
        ("melpa_local" . "/home/apopov/emacs-pkgs/melpa")))

(package-initialize)
;; uncomment next line if there is a problem with GPG
;; (setq package-check-signature nil)

(load "~/.emacs.d/keys.el")
(load "~/.emacs.d/view.el")
(load "~/.emacs.d/ffap.el")
(load "~/.emacs.d/goods.el")

(load "~/.emacs.d/modes/my-common-prog.el")
(load "~/.emacs.d/modes/c-common.el")
(load "~/.emacs.d/modes/go.el")
(load "~/.emacs.d/modes/python.el")
(load "~/.emacs.d/modes/emacs-lisp.el")
(load "~/.emacs.d/modes/json.el")
(load "~/.emacs.d/modes/java.el")
(load "~/.emacs.d/modes/latex.el")
(load "~/.emacs.d/modes/text.el")
(load "~/.emacs.d/modes/graphviz-dot.el")
(load "~/.emacs.d/modes/sh.el")
(load "~/.emacs.d/modes/markdown.el")
(load "~/.emacs.d/modes/rst.el")
(load "~/.emacs.d/modes/feature.el")
(load "~/.emacs.d/modes/js2.el")
