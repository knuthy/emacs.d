(defconst evil-elscreen-version "0.1")
;;   (require 'evil-elscreen)
(require 'elscreen)

;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################

;;;;;;;; Opening a new page

(evil-define-command evil-elscreen/tab-new (file)
  "Open a new tab page and edit {file}, like with :edit.
If the {file} is nil, create a new tab page with *scratch* buffer, after the current tab page."
  :repeat nil
  (interactive "<f>")
  (if file
      (elscreen-find-file file)
    (elscreen-create)))

(evil-define-command evil-elscreen/tab-find (file)
  "Open a new tab page and edit {file} in 'path', like with :find. "
  :repear nil
  (interactive "<f>")
  (if file
      (elscreen-find-file file)
    (message "Error: need argument")
    ))

;; FIXME: need to add a function that return if command does not exist
;;        maybe fix vim:ex-execute-command will do the work
;; (vim:defcmd evil-elscreen/tab-command ((argument:text text) nonrepeatable)
;;   "Execute {cmd} and when it opens a new window open a new tab
;;    page instead.  Doesn't work for :diffsplit, :diffpatch,:execute and :normal.
;;    Examples: >
;; 	     :tab split      'opens current buffer in new tab page'"
;;   (if text
;;       (progn
;; 	(elscreen-create)
;; 	(vim:ex-execute-command text))
;;     ;; TODO: If command does not exist, do something
;;     ))

;; TODO:
;; CTRL-W gf       Open a new tab page and edit the file name under the cursor.
;;                 See CTRL-W_gf.

;; CTRL-W gF       Open a new tab page and edit the file name under the cursor
;;                 and jump to the line number following the file name.
;;                 See CTRL-W_gF.



;;;;;;;; Closing a tab page

;; FIXME: in vim, tabclose cant have {count}
(evil-define-command evil-elscreen/tab-close ()
  "Close current tab page. However the buffer still alive."
  :repeat nil
  (interactive)
  (elscreen-kill))

(evil-define-command evil-elscreen/tab-close-f ()
  "Close current tab page. and also kill current buffer."
  :repeat nil
  (interactive)
  (kill-buffer)
  (elscreen-kill))

(evil-define-command evil-elscreen/tab-close-other ()
  "Close all other tabpages. Do not kill other buffers"
  :repeat nil
  (interactive)
  (elscreen-kill-others))

(evil-define-command evil-elscreen/tab-close-other-f ()
  "Close all other tabpages and alos kill other buffers"
  :repeat nil
  (interactive)
  (elscreen-kill-others)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

;;;;;;;; Switching to another tab page

(evil-define-command evil-elscreen/tab-next (&optional count argument)
  ""
  :repeat nil
  (interactive "p")
  (if elscreen-display-screen-number
      (progn
	(if (eq last-command #'evil-beginning-of-line-or-digit-argument)
	    (setq count 0))
	(cond
	 (argument (elscreen-goto (string-to-number argument)))
	 (count  (elscreen-goto count))
	 (t (elscreen-next))))
    ;; If tab does not display number, do the same as vim's :tabnext
    (cond
     (argument (dotimes (dummy (string-to-number argument))
		 (elscreen-next)))
     (count (dotimes (dummy count)
	      (elscreen-next)))
     (t (elscreen-next)))))


(evil-define-command evil-elscreen/tab-previous (&optional count argument)
  ""
  :repeat nil
  (interactive "p")
  (if elscreen-display-screen-number
      (progn
	(if (eq last-command #'evil-beginning-of-line-or-digit-argument)
	    (setq count 0))
	(cond
	 (argument (elscreen-goto (string-to-number argument)))
	 (count (elscreen-goto count))
	 (t (elscreen-previous))))
    ;; If tab does not display number, do the same as vim's :tabprevious
    (cond
     (argument (dotimes (dummy (string-to-number argument))
		 (elscreen-previous)))
     (count (dotimes (dummy count)
	      (elscreen-previous)))
     (t (elscreen-previous)))))


;;;;;;;; evil-mode keymaps
;; Normal map
(defun vimlike-quit ()
  "Vimlike ':q' behavior: close current window if there are split windows;
otherwise, close current tab (elscreen)."
  (interactive)
  (let ((one-elscreen (elscreen-one-screen-p))
        (one-window (one-window-p))
        )
    (cond
     ; if current tab has split windows in it, close the current live window
     ((not one-window)
      (delete-window) ; delete the current window
      (balance-windows) ; balance remaining windows
      nil)
     ; if there are multiple elscreens (tabs), close the current elscreen
     ((not one-elscreen)
      (elscreen-kill)
      nil)
     ; if there is only one elscreen, just try to quit (calling elscreen-kill
     ; will not work, because elscreen-kill fails if there is only one
     ; elscreen)
     (one-elscreen
      (evil-quit)
      nil)
     )))
(defun vimlike-write-quit ()
  "Vimlike ':wq' behavior: write then close..."
  (interactive)
  (save-buffer)
  (vimlike-quit))
(evil-ex-define-cmd "q" 'vimlike-quit)
(evil-ex-define-cmd "wq" 'vimlike-write-quit)

(define-key evil-normal-state-map (kbd "<f12>") 'elscreen-next)
(define-key evil-normal-state-map (kbd "<f11>") 'elscreen-previous)
(define-key evil-normal-state-map (kbd "<f10>") 'elscreen-create)
(define-key evil-normal-state-map (kbd "<f9>") 'elscreen-close)

;; ex command
(evil-ex-define-cmd "tabnew" 'evil-elscreen/tab-new)
(evil-ex-define-cmd "tabedit" "tabnew")
(evil-ex-define-cmd "tabe" "tabedit")
(evil-ex-define-cmd "tabfind" 'evil-elscreen/tab-find)
(evil-ex-define-cmd "tabf" "tabfind")
;;(evil-ex-define-cmd "tab" 'evil-elscreen/tab-command)
(evil-ex-define-cmd "tabclose" 'evil-elscreen/tab-close)
(evil-ex-define-cmd "tabc" "tabclose")
(evil-ex-define-cmd "tabclose!" 'evil-elscreen/tab-close-f)
(evil-ex-define-cmd "tabc!" "tabclose!")
(evil-ex-define-cmd "tabonly" 'evil-elscreen/tab-close-other)
(evil-ex-define-cmd "tabo" "tabonly")
(evil-ex-define-cmd "tabonly!" 'evil-elscreen/tab-close-other-f)
(evil-ex-define-cmd "tabo!" "tabonly!")
(evil-ex-define-cmd "tabnext" 'evil-elscreen/tab-next)
(evil-ex-define-cmd "tabn" "tabnext")
(evil-ex-define-cmd "tabprevious" 'evil-elscreen/tab-previous)
(evil-ex-define-cmd "tabp" "tabprevious")
(evil-ex-define-cmd "tabNext" "tabprevious")
(evil-ex-define-cmd "tabN" "tabprevious")

(provide 'evil-elscreen)
;; evil-elscreen.el ends here.
