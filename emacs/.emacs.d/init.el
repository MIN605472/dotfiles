;; UI
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(set-face-attribute 'default nil
		    :font "Iosevka"
		    :height 95
		    :weight 'medium)

;; Auto-save and auto-backup. Disable them for now.
(setq auto-save-default nil)
(setq make-backup-files nil)

;; General settings
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)
(setq-default  indent-tabs-mode nil
	       tab-width 2
	       css-indent-offset 2)
(delete-selection-mode 1)

;; Packages
(require 'package)
;; (setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

;; Other themes: kaolin-themes, ample-theme
(use-package doom-themes
  :config
  (load-theme 'doom-one-light t))

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package which-key
  :config
  (which-key-mode))

(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "[%d/%d] "))

(use-package undo-tree
  :config
  (global-undo-tree-mode))

(use-package magit
  :bind
  ("C-x g" . 'magit-status))

(use-package telephone-line
  :config
  (setq telephone-line-height 20)
  (telephone-line-mode 1))

(use-package all-the-icons)

(use-package nov
  :config
  (setq nov-text-width 80)
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  (defun my-nov-font-setup ()
    (face-remap-add-relative 'variable-pitch :family "Libre Baskerville"
                             :height 1.1))
  (add-hook 'nov-mode-hook 'my-nov-font-setup))

(use-package org
  :ensure org-plus-contrib
  :pin org
  :mode ("\\.org\\'" . org-mode)
  :config
  (add-to-list 'org-modules 'org-drill))

;; (use-package evil
;;   :config
;;   (evil-mode 1))
