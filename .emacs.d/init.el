;; init.el

;; package repositories

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))

;; increase emacs garbage collection
(setq gc-cons-threshold 64000000)
(add-hook 'after-init-hook #'(lambda ()
                               ;; restore after startup
                               (setq gc-cons-threshold 800000)))

;; always show line numbers
(global-linum-mode 1)

;; always show line we are currently on
(global-hl-line-mode t)

;; can't see comments with default hl color
(set-face-background 'hl-line "#372E2D")

;; turn on highlight matching brackets when cursor is on one
(show-paren-mode t)

;; show column numbers by default
(setq column-number-mode t)

;; disable bars
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; avoid tab for indentation
(setq-default indent-tabs-mode nil)

;; no backup files please
(setq make-backup-files nil)

;; misc
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)

;; no splash screeb
(setq inhibit-splash-screen t)


(defun copy-to-clipboard ()
  (interactive)
  (if (display-graphic-p)
      (progn
        (message "Yanked region to x-clipboard!")
        (call-interactively 'clipboard-kill-ring-save)
        )
    (if (region-active-p)
        (progn
          (shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
          (message "Yanked region to clipboard!")
          (deactivate-mark))
      (message "No region active; can't yank to clipboard!"))))

(defun paste-from-clipboard ()
  (interactive)
  (if (display-graphic-p)
      (progn
        (clipboard-yank)
        (message "graphics active")
        )
    (insert (shell-command-to-string "xsel -o -b"))))

(global-set-key (kbd "C-c C-w") 'copy-to-clipboard)
(global-set-key (kbd "C-c C-y") 'paste-from-clipboard)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e" default)))
 '(package-selected-packages
   (quote
    (auctex autopair window-numbering magit dracula-theme ivy rainbow-delimiters company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (require 'use-package)

;; dracula
(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula))


;; company
(use-package company
  :ensure t
  :commands company-mode
  :init
  ;; zero delay when pressing tab
  (setq company-idle-delay 0))

;; ivy
(use-package ivy
  :demand t
  :ensure t
  :commands (ivy-mode)
  :config
  (require 'ivy)
  (ivy-mode t)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  :bind (("C-x b" . ivy-switch-buffer)
         ("C-x B" . ivy-switch-buffer-other-window)))

;; counsel
(use-package counsel
  :ensure t
  :bind (("C-x C-f" . counsel-find-file)
         ("<f1> f" . counsel-describe-function)
         ("<f1> v" . counsel-describe-variable)))

;; magit
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;; rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; window numbering
(use-package window-numbering
  :ensure t
  :config
  (window-numbering-mode t))

;; autopair
(use-package autopair
  :ensure t
  :config
  (autopair-global-mode t))

;; init.el ends here
