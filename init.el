;;;Remove startup page
(setq inhibit-startup-message t)

;;Remove menues
(tool-bar-mode -1)
(menu-bar-mode -1)

;;remove scroll bar
(scroll-bar-mode -1)

;;add line numbers
(global-linum-mode t)

;;font size
(set-face-attribute 'default nil :height 140)

;;packages

(require 'package)
(setq package-enable-at-startup nil)

;; MELPA repository
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;;Initialize packages
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (progn
    (which-key-mode)
    (which-key-setup-side-window-bottom)
    ))
  
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)))

(use-package all-the-icons
  :ensure t)

(use-package neotree
  :ensure t
  :config
  (progn
    (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
  :bind
  (("C-b" . 'neotree-toggle)))


(use-package ace-window
  :ensure t
  :bind (("C-x o" . ace-window)))

(use-package ergoemacs-mode
  :ensure t
  :config
  (progn
   (setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
   (setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
   (ergoemacs-mode 1)
   ))

(use-package solarized-theme
  :ensure t
  :config(load-theme 'solarized-dark t))


(use-package flycheck
  :ensure t
  :init(global-flycheck-mode t))

;;Functions


(defun duplicate-line-or-region (&optional n)
"Duplicate current line, or region if active.
With argument N, make N copies.
With negative N, comment out original line and use the absolute value."

(interactive "*p")
  (let ((use-region (use-region-p)))
    (save-excursion
      (let ((text (if use-region        ;Get region if active, otherwise line
		      (buffer-substring (region-beginning) (region-end))
                    (prog1 (thing-at-point 'line)
                      (end-of-line)
                      (if (< 0 (forward-line 1)) ;Go to beginning of next line, or make a new one
                          (newline))))))
        (dotimes (i (abs (or n 1)))     ;Insert N times, or once if not specified
          (insert text))))
    (if use-region nil                  ;Only if we're working with a line (not a region)
      (let ((pos (- (point) (line-beginning-position)))) ;Save column
        (if (> 0 n)                             ;Comment out original with negative arg
            (comment-region (line-beginning-position) (line-end-position)))
        (forward-line 1)
        (forward-char pos)))))

;; our shortcuts
(global-set-key (kbd "C-d") 'duplicate-line-or-region)
(global-set-key (kbd "M-<down>") 'enlarge-window)
(global-set-key (kbd "M-<up>") 'shrink-window)
(global-set-key (kbd "M-<left>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<right>") 'shrink-window-horizontally)
(global-set-key (kbd "C-<tab>") 'other-window)






;;melpa stuff
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(flycheck color-theme-sanityinc-tomorrow solarized-theme ergoemacs-mode ace-window ace-windows all-the-icons neotree auto-complete which-key-posframe which-key-postframe which-key wich-key try use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
