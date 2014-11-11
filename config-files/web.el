(unless (require 'web-mode nil 'noerror)
    (el-get-install 'web-mode))
(unless (require 'js2-mode nil 'noerror)
    (el-get-install 'js2-mode))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-indent-offset 4)
  (setq web-mode-comment-style 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)

  (setq web-mode-enable-css-colorization t)
)

(add-hook 'web-mode-hook 'web-mode-hook)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(custom-set-variables  
 '(js2-basic-offset 2)  
 '(js2-bounce-indent-p t)  
)
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(require-package 'smart-tabs-mode)
(smart-tabs-insinuate 'c 'javascript)
(smart-tabs-advice js2-indent-line js2-basic-offset)
