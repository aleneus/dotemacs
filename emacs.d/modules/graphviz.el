(defun my-graphviz-dot-mode-hook ()
  (require 'graphviz-dot-mode)
  (setq graphviz-dot-indent-width 4))

(add-hook 'graphviz-dot-mode-hook 'my-graphviz-dot-mode-hook)
