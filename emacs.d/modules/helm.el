;; use helm for basic things

(use-package helm
  :ensure t
  :init
  (setq helm-find-files-sort-directories t)
  :bind (
		 ("M-x" . helm-M-x)
		 ("C-x C-f" . helm-find-files)
		 ("C-x b" . helm-buffers-list))
  :config
  (helm-mode 1)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action)
  (define-key helm-find-files-map (kbd "<tab>") 'helm-execute-persistent-action))
