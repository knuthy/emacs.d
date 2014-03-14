(autoload 'python-mode "python-mode.el" "Python mode." t)
(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))

(require-package 'jedi)
(require-package 'deferred)
(require-package 's)
(require 'deferred)
(require 's)
(require 'cl)
(require 'jedi)

(add-hook 'python-mode-hook 'auto-complete-mode)
(add-hook 'python-mode-hook 'jedi:ac-setup)
