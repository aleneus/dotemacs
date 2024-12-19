(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

(defun my-octave-mode-hook ()
  (common-prog))

(add-hook 'octave-mode-hook 'my-octave-mode-hook)
