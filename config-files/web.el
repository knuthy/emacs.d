(unless (require 'web-mode nil 'noerror)
    (el-get-install 'web-mode))
(unless (require 'js2-mode nil 'noerror)
    (el-get-install 'web-mode))

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

  (define-key evil-normal-state-map (kbd "C-;") 'web-mode-comment-or-uncomment)

  (setq web-mode-extra-snippets
        '(("erb" . (("name" . ("beg" . "end"))))
          ("php" . (("name" . ("beg" . "end"))
                    ("name" . ("beg" . "end"))))
          ))
  (setq web-mode-extra-auto-pairs
        '(("erb" . (("open" "close")))
          ("php" . (("open" "close")
                    ("open" "close")))
          ))
)

(add-hook 'web-mode-hook 'web-mode-hook)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js-mode-hook 'js2-minor-mode)
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
