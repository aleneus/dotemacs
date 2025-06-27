(use-package python
  :hook
  (python-mode . common-prog)
  (before-save . yapfify-buffer))
