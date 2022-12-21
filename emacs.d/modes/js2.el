(defun my-js-hook ()
  ;; NOTE: install npm: https://losst.ru/ustanovka-node-js-ubuntu-18-04
  ;; NOTE: install tern: sudo npm install -g tern

  (require 'ac-js2)
  (require 'ag)
  (require 'coffee-mode)
  (require 'js2-mode)
  (require 'js2-refactor)
  (require 'json-mode)
  (require 'tern)
  (require 'tern-auto-complete)
  (require 'xref-js2)

  (my-common-prog)

  (eval-after-load 'tern
    '(progn
       (tern-ac-setup)))

  (tern-mode)
  (auto-complete-mode))

(add-hook 'js2-mode-hook 'my-js-hook)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(require 'company)

(add-to-list 'company-backends 'ac-js2-company)

(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)
(add-hook 'js2-mode-hook #'js2-refactor-mode)

(add-hook 'js2-mode-hook (lambda ()
  (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))
