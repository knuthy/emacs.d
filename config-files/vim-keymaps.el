;;;; global

(define-key evil-normal-state-map ";" 'evil-ex)
(define-key evil-normal-state-map "v" 'evil-visual-block)
(define-key evil-normal-state-map (kbd "C-v") 'evil-visual-state)

(define-key evil-normal-state-map "  " 'ace-jump-mode)
(define-key evil-normal-state-map " k" 'ace-jump-char-mode)
(define-key evil-normal-state-map " l" 'ace-jump-line-mode)
;(define-key evil-normal-state-map " s" 'textmate-goto-symbol)
(define-key evil-normal-state-map " m" 'evil-jump-item)
(define-key evil-normal-state-map ",," 'evil-buffer)
(define-key evil-normal-state-map "-" 'delete-other-windows)
(define-key evil-normal-state-map "b" 'ido-switch-buffer)
(define-key evil-normal-state-map "B" 'magit-checkout)
(define-key evil-normal-state-map "E" 'ido-find-file)
;; (define-key evil-normal-state-map "\\" 'evil-repeat-find-char-reverse)
(define-key evil-normal-state-map "H" 'evil-first-non-blan)
(define-key evil-normal-state-map "Y" 'copy-to-end-of-line)
(define-key evil-normal-state-map "L" 'evil-last-non-blank)
(define-key evil-normal-state-map (kbd "<tab>") 'indent-for-tab-command)
(define-key evil-normal-state-map (kbd "<C-return>") 'new-line-in-normal-mode)
(define-key evil-normal-state-map (kbd "M-t") 'multi-term)
(define-key evil-normal-state-map (kbd "M-F") 'dired)
(define-key evil-normal-state-map (kbd "C-w") 'delete-trailing-whitespace)
(define-key evil-normal-state-map (kbd "M-j") 'evil-window-next)
(define-key evil-normal-state-map (kbd "M-k") 'evil-window-prev)
(define-key evil-normal-state-map (kbd "M-.") 'my-find-tag)
(define-key evil-normal-state-map (kbd "C-w") 'delete-trailing-whitespace)
(define-key evil-normal-state-map (kbd "C-SPC") 'comment-or-uncomment-region-or-line)
(define-key evil-normal-state-map (kbd "M-o") 'session-jump-to-last-change)

(evil-define-key 'visual global-map (kbd ",re") 'dr/extract-variable)
(evil-define-key 'normal global-map (kbd ",ri") 'dr/inline-variable)

(global-set-key [f1] 'magit-status)
(global-set-key [f2] 'writeroom-mode)
(global-set-key [f5] 'my-clear-all-caches)
(global-set-key [escape] 'keyboard-quit)
(global-set-key (kbd "M-a") 'mark-whole-buffer)
(global-set-key (kbd "C-\\") 'highlight-symbol-at-point)
(global-set-key (kbd "<M-up>") 'er/expand-region) ;
(global-set-key (kbd "<M-down>") 'er/contract-region)
(global-set-key (kbd "C-<backspace>") 'my-delete-backwards)
(global-set-key (kbd "RET") 'newline-and-indent)
;; (global-set-key (kbd "M-]") 'textmate-shift-right)
;; (global-set-key (kbd "M-[") 'textmate-shift-left)
(global-set-key (kbd "M-j") 'other-window)
(global-set-key (kbd "M-k") 'yas-expand-from-trigger-key)
(global-set-key (kbd "M-.") 'my-find-tag)
(global-set-key (kbd "M-b") 'ibuffer)
(global-set-key (kbd "M-v") 'evil-paste-after)

(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-w") 'quit-window)
(global-set-key (kbd "M-W") 'projectile-kill-buffers)

;;; iedit

;; (global-set-key (kbd "M-L") 'iedit-mode)
;; (global-set-key (kbd "M-l") 'iedit-dwim)

;;; cursors

(global-set-key (kbd "M-L") 'skip-current-mark-and-mark-next)
(global-set-key (kbd "M-l") 'mc/mark-next-like-this)
;;; drop some keymaps


;;; i miss intellij
(global-set-key (kbd "M-q") 'evil-quit-all)
(evil-define-key 'visual global-map
  (kbd "M-d") 'duplicate-region)

(evil-define-key 'normal global-map
  (kbd "M-d") 'duplicate-line)

(evil-define-key 'insert global-map
  (kbd "M-d") 'duplicate-line
  (kbd "M-<backspace>") 'kill-whole-line
  (kbd "M-J") 'evil-join
  (kbd "M-<return>") 'evil-open-below
  (kbd "M-<left>") 'evil-first-non-blank
  (kbd "M-<right>") 'move-end-of-line)


;;; javascript

;; (evil-declare-key 'insert js3-mode-map (kbd "M-k") 'insert-js-function)
(evil-declare-key 'normal js3-mode-map
                  ",g" 'add-to-js-globals
                  ",d" 'js-log-line
                  ",t," 'tjs-toggle-test-and-implementation
                  ",ta" 'tjs-run-acceptance
                  ",tu" 'tjs-run-unit
                  ",tc" 'tjs-run-client
                  ",tl" 'tjs-run-last)

;; isearch

(global-set-key (kbd "M-f") 'isearch-forward)
(global-set-key (kbd "M-r") 'isearch-backward)
(define-key isearch-mode-map [escape] 'isearch-cancel)
(define-key isearch-mode-map (kbd "M-f") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "M-r") 'isearch-repeat-backward)

;;; comint

(defun kill-comint ()
  (interactive)
  (comint-interrupt-subjob)
  (popwin:close-popup-window))

(evil-define-key 'normal comint-mode-map (kbd "C-q") 'kill-comint)
(evil-define-key 'normal comint-mode-map (kbd "q") 'popwin:close-popup-window)

;;; org

(evil-define-key 'normal org-mode-map
  (kbd "<tab>") 'org-cycle
  (kbd "M-L") 'org-metaright
  (kbd "M-H") 'org-metaleft
  (kbd "M-J") 'org-metadown
  (kbd "M-K") 'org-metaup
  (kbd "C-=") 'org-todo
  (kbd "M--") 'evil-org-normal-heading
  (kbd "C-j") 'org-forward-same-level
  (kbd "C-k") 'org-backward-same-level
  (kbd "M-_") 'evil-org-heading-after-current)

(evil-define-key 'insert org-mode-map
  (kbd "C-=") 'org-todo
  (kbd "M-l") 'org-metaright
  (kbd "M-h") 'org-metaleft
  (kbd "M-j") 'org-metadown
  (kbd "M-k") 'org-metaup
  (kbd "M--") 'evil-org-normal-heading
  (kbd "M-_") 'evil-org-heading-after-current)

;; ;;; fuzzy find

;; (fuzzy-find-initialize)
;; (define-key fuzzy-find-keymap "\M-n" 'fuzzy-find-next-completion)
;; (define-key fuzzy-find-keymap "\M-p" 'fuzzy-find-previous-completion)

;;; Magit

(evil-define-key 'normal magit-log-edit-mode-map "q" 'magit-log-edit-commit)

;;; Stuff I had some trouble defining normally

(add-hook 'ido-minibuffer-setup-hook
          (lambda ()
            (define-key ido-completion-map (kbd "M-n") 'ido-next-match)
            (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
            (define-key ido-completion-map (kbd "M-p") 'ido-prev-match)
            (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)))

;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (local-set-key (kbd "RET") 'newline-and-indent)))

;; (Add-hook 'change-major-mode-hook
;;           (lambda ()
;;             (global-set-key (kbd "C-/") 'comment-or-uncomment-region-or-line)))


(add-hook 'dired-mode-hook (lambda ()
  (define-key dired-mode-map "U" 'dired-up-directory)
  (define-key dired-mode-map "/" 'dired-isearch-filenames)))

(add-hook 'railway-minor-mode-hook 'evil-normalize-keymaps)

;; use C-; to comment/uncomment region and line
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (next-line)))

(define-key evil-normal-state-map (kbd "C-;") 'comment-or-uncomment-region-or-line)
(define-key evil-visual-state-map (kbd "C-;") 'comment-or-uncomment-region-or-line)
(define-key evil-insert-state-map (kbd "C-;") 'comment-or-uncomment-region-or-line)

;;;
;;; C-q as general purpose escape key sequence.
(defun my-esc (prompt)
  "Functionality for escaping generally.  Includes exiting Evil insert state and C-g binding. "
  (cond
   ((or (evil-insert-state-p)
        (evil-normal-state-p)
        (evil-replace-state-p)
        (evil-visual-state-p)) [escape])
   (t (kbd "C-g"))))

(define-key key-translation-map (kbd "C-q") 'my-esc)
(define-key evil-operator-state-map (kbd "<C-q>") 'keyboard-quit)
(set-quit-char "C-q")
;;; Some keybindings

(provide 'vim-keymaps)
