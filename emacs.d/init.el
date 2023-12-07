(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Settings that do not require the installation of
;; additional packages
(load "~/.emacs.d/modules/gui.el")
(load "~/.emacs.d/modules/backup.el")
(load "~/.emacs.d/modules/editing.el")
(load "~/.emacs.d/modules/ffap.el")


;; Other settings with additional packages
(load "~/.emacs.d/modules/packages.el")

(load "~/.emacs.d/modules/scrolling.el")
;; (load "~/.emacs.d/modules/icons.el")
(load "~/.emacs.d/modules/popwin.el")
(load "~/.emacs.d/modules/navigation.el")


;; Modes for writing code
(load "~/.emacs.d/modules/common-prog.el")

(load "~/.emacs.d/modules/c-cpp.el")
(load "~/.emacs.d/modules/go.el")
(load "~/.emacs.d/modules/python.el")
(load "~/.emacs.d/modules/lisp.el")
(load "~/.emacs.d/modules/json.el")
(load "~/.emacs.d/modules/java.el")
(load "~/.emacs.d/modules/latex.el")
(load "~/.emacs.d/modules/text.el")
(load "~/.emacs.d/modules/graphviz.el")
(load "~/.emacs.d/modules/sh.el")
(load "~/.emacs.d/modules/markdown.el")
(load "~/.emacs.d/modules/rst.el")
(load "~/.emacs.d/modules/feature.el")
(load "~/.emacs.d/modules/js2.el")

(shell)
(delete-other-windows)
