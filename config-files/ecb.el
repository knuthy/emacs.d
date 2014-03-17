(require-package 'ecb)
(require-package 'autopair)
(require 'ecb)
(require 'ecb-autoloads)

(require 'speedbar)

;;; activate and deactivate ecb
(define-key evil-normal-state-map ",e" 'ecb-activate)
(define-key evil-normal-state-map ",d" 'ecb-deactivate)
;;; show/hide ecb window
(define-key evil-normal-state-map ",s" 'ecb-show-ecb-windows)
(define-key evil-normal-state-map ",h" 'ecb-hide-ecb-windows)
;;; quick navigation between ecb windows
(global-set-key (kbd "C-)") 'ecb-goto-window-edit1)
(global-set-key (kbd "C-!") 'ecb-goto-window-directories)
(global-set-key (kbd "C-@") 'ecb-goto-window-sources)
(global-set-key (kbd "C-#") 'ecb-goto-window-methods)
(global-set-key (kbd "C-$") 'ecb-goto-window-compilation)
;;; Open file
(define-key evil-normal-state-map (kbd "M-l") 'ecb-open-source-in-editwin1)
(setq ecb-tip-of-the-day nil)

(ecb-layout-define "cppide" left nil
  ;; The frame is already splitted side-by-side and point stays in the
  ;; left window (= the ECB-tree-window-column)

  ;; Here is the creation code for the new layout
  (ecb-set-methods-buffer)
  (ecb-split-ver 0.25 t)
  (other-window 1)
  (ecb-set-speedbar-buffer)
  ;; 5. Make the ECB-edit-window current (see Postcondition above)
  (select-window (next-window)))

;; enable ECB automaticaly
(setq ecb-layout-name "left13")
(setq ecb-show-sources-in-directories-buffer 'always)

(defun cmodehook()
    ;; some customization to be used when C/C++ file is opened

    (setq ecb-layout-name "cppide")
    (ecb-use-speedbar-instead-native-tree-buffer)

    (setq-default c-basic-offset 4 c-default-style "linux")
    (setq-default tab-width 4 indent-tabs-mode t))

(add-hook 'c-mode-common-hook 'cmodehook)

;; (require 'member-function)
;; (setq mf--source-file-extension "cpp")
