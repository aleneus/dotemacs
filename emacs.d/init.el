(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Uncomment if problem with signature
;; (setq package-check-signature nil)

;; Settings that do not require the installation of
;; additional packages
(load "~/.emacs.d/modules/gui.el")
(load "~/.emacs.d/modules/backup.el")
(load "~/.emacs.d/modules/editing.el")
(load "~/.emacs.d/modules/ffap.el")

;; Other settings with additional packages
;; (load "~/.emacs.d/modules/packages.el")
;; (load "~/.emacs.d/modules/scrolling.el")
;; (load "~/.emacs.d/modules/icons.el")
;; (load "~/.emacs.d/modules/navigation.el")

;; Writing text
;; (load "~/.emacs.d/modules/text.el")
;; (load "~/.emacs.d/modules/markdown.el")
;; (load "~/.emacs.d/modules/json.el")
;; (load "~/.emacs.d/modules/rst.el")
;; (load "~/.emacs.d/modules/feature.el")
;; (load "~/.emacs.d/modules/latex.el")
;; (load "~/.emacs.d/modules/graphviz.el")

;; Writing code
;; (load "~/.emacs.d/modules/common-prog.el")
;; (load "~/.emacs.d/modules/sideline.el")
;; (load "~/.emacs.d/modules/lisp.el")
;; (load "~/.emacs.d/modules/c-cpp.el")
;; (load "~/.emacs.d/modules/go.el")
;; (load "~/.emacs.d/modules/python-lsp.el") ;; or
;; (load "~/.emacs.d/modules/python-elpy.el")
;; (load "~/.emacs.d/modules/sh.el")
;; (load "~/.emacs.d/modules/octave.el")
;; (load "~/.emacs.d/modules/java.el")
;; (load "~/.emacs.d/modules/js2.el")
(load "~/.emacs.d/modules/graphviz.el")

;; Telegram
(load "~/.emacs.d/modules/tg.el")

;; Org modes
;; (load "~/.emacs.d/modules/org.el")
;; (load "~/.emacs.d/modules/roam.el")

;; Open shell at startup
;; (shell)
;; (delete-other-windows)
