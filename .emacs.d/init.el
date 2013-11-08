(add-to-list 'load-path (concat user-emacs-directory "lisp"))

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(setq default-major-mode 'text-mode)
(setq frame-title-format '(buffer-file-name "%f" ("%b")))

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(if (eq system-type 'darwin)
    (progn
      (setq mac-option-key-is-meta t)
      (setq mac-right-option-modifier nil)))

(setq make-backup-files nil)
(setq version-control 'never)

(defalias 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore)

(setq-default indent-tabs-mode nil)
(setq c-default-style "k&r" c-basic-offset 4)

(setq nxml-child-indent 4)

(delete-selection-mode 1)
(setq mouse-yank-at-point t)
(setq mouse-wheel-scroll-amount '(1 ((shift))))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(unless (eq window-system 'ns)
  (menu-bar-mode -1))
(tooltip-mode -1)
(line-number-mode 1)
(column-number-mode 1)
(blink-cursor-mode 1)
(show-paren-mode 1)

(setq ediff-window-setup-function (quote ediff-setup-windows-plain))
(setq ediff-split-window-function (quote split-window-horizontally))

;;(defun compilation-hook()
;;  (when (not (get-buffer-window "*compilation*"))
;;    (save-selected-window
;;      (save-excursion
;;        (let* ((w (split-window-vertically))
;;               (h (window-height w)))
;;          (select-window w)
;;          (switch-to-buffer "*compilation*"))))))
;;(add-hook 'compilation-mode-hook 'compilation-hook)
(setq compilation-scroll-output t)

(defun toggle-fullscreen ()
  (interactive)
  (cond ((eq window-system 'x)
         (set-frame-parameter
          nil 'fullscreen
          (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))
  (cond ((eq window-system 'w32)
         (shell-command "emacs_fullscreen.exe"))))

(if (eq window-system 'x)
    (progn
      (global-set-key (kbd "<f11>") 'toggle-fullscreen)))
(if (eq window-system 'w32)
    (progn
      (global-set-key (kbd "<M-return>") 'toggle-fullscreen)))


(if (eq window-system 'x)
    (progn
      (set-frame-font "DejaVu Sans Mono-11")))
(if (eq window-system 'ns)
    (progn
      (set-frame-font "Menlo-13")))
(if (eq window-system 'w32)
    (progn
      (set-frame-font "DejaVu Sans Mono-10")))

(setq delete-by-moving-to-trash t)
(if (eq window-system 'ns)
    (progn
      (setq trash-directory "~/.Trash/emacs")))

(setq x-select-enable-clipboard t)

(global-set-key (kbd "<M-down>") 'scroll-up-line)
(global-set-key (kbd "<M-up>") 'scroll-down-line)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "S-s-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "S-s-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "S-s-<up>") 'enlarge-window)
(global-set-key (kbd "s-<down>") 'windmove-down)
(global-set-key (kbd "S-s-<down>") 'shrink-window)
(global-set-key (kbd "C-l") 'goto-line)
(global-set-key (kbd "C-k") 'kill-whole-line)
(global-set-key (kbd "<M-f9>") 'compile)
(global-set-key (kbd "<f9>") 'recompile)
(global-set-key (kbd "M-]") 'next-error)
(global-set-key (kbd "M-[") 'previous-error)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'revbufs)

(defun snippet-include (name)
  (interactive "sEnter name of sentinel macro: ")
  (insert (format "#ifndef %s\n#define %s\n\n#endif\n" name name)))

(defun hide-ctrl-m ()
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(eval-after-load "exec-path-from-shell-autoloads"
  '(progn
     (exec-path-from-shell-initialize)))

(eval-after-load "ggtags-autoloads"
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode)
                (ggtags-mode 1)))))

(eval-after-load "magit-autoloads"
  '(progn
     (global-set-key (kbd "C-x g") 'magit-status)))

(eval-after-load "cygwin-mount-autoloads"
  '(progn
     (require 'setup-cygwin)))

(defconst local-el (concat user-emacs-directory "local.el"))
(if (file-readable-p local-el) (load-file local-el) nil)
