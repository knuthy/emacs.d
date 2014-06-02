; install scala-mode2 and sbt-mode
(unless (package-installed-p 'scala-mode2)
  (package-refresh-contents) (package-install 'scala-mode2))
(unless (package-installed-p 'sbt-mode)
  (package-refresh-contents) (package-install 'sbt-mode))

(require 'scala-mode2)
(require 'sbt-mode)

(add-hook 'sbt-mode-hook '(lambda ()
    ;; compilation-skip-threshold tells the compilation minor-mode
    ;; which type of compiler output can be skipped. 1 = skip info
    ;; 2 = skip info and warnings.
    (setq compilation-skip-threshold 1)

    ;; Bind C-a to 'comint-bol when in sbt-mode. This will move the
    ;; cursor to just after prompt.
    (local-set-key (kbd "C-a") 'comint-bol)

    ;; Bind M-RET to 'comint-accumulate. This will allow you to add
    ;; more than one line to scala console prompt before sending it
    ;; for interpretation. It will keep your command history cleaner.
    (local-set-key (kbd "M-RET") 'comint-accumulate)
))

(add-hook 'scala-mode-hook '(lambda ()
    ;; sbt-find-definitions is a command that tries to find (with grep)
    ;; the definition of the thing at point.
    (local-set-key (kbd "M-.") 'sbt-find-definitions)

    ;; use sbt-run-previous-command to re-compile your code after changes
    (define-key evil-normal-state-map ",x" 'sbt-run-previous-command)
))
