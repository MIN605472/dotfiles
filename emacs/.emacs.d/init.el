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
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "org" (concat proto "://orgmode.org/elpa/")) t)
  (when (< emacs-major-version 24)
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

;; Themes related config
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; (set-face-attribute 'default nil
;; 		    :font "Iosevka"
;; 		    :height 95
;; 		    :weight 'medium)
;; (set-frame-font "Iosevka 10" nil t)
(add-to-list 'default-frame-alist
             '(font . "Iosevka 10"))

(use-package all-the-icons)

;; Other themes: kaolin-themes, ample-theme, doom-themes
(use-package doom-themes
  :config
  (load-theme 'doom-one-light t))

;; (use-package doom-modeline
;;   :defer t
;;   :hook (after-init . doom-modeline-init))

;; (use-package auto-package-update
;;   :config
;;   (setq auto-package-update-delete-old-versions t)
;;   (setq auto-package-update-hide-results t)
;;   (auto-package-update-maybe))

(use-package which-key
  :config
  (which-key-mode))

(use-package swiper)
(use-package ivy
  :config
  (ivy-mode 1)
  (counsel-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "[%d/%d] ")
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag))

(use-package undo-tree
  :config
  (global-undo-tree-mode))

(use-package magit
  :bind
  ("C-x g" . 'magit-status))

(use-package nov
  :config
  (setq nov-text-width 80)
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  (defun my-nov-font-setup ()
    (face-remap-add-relative 'variable-pitch :family "Libre Baskerville"
                             :height 1.1))
  (add-hook 'nov-mode-hook 'my-nov-font-setup))


;; (use-package graphql)

;; dired
(setq dired-listing-switches "-aBhlt --group-directories-first")

;; (use-package evil
;;   :config
;;   (evil-mode 1))

(use-package mu4e-contrib
  :ensure nil
  :custom
  (mu4e-headers-date-format "%Y-%m-%d %H.%M")
  (mu4e-use-fancy-chars nil)
  (mu4e-completing-read-function 'ivy-completing-read)
  (mu4e-confirm-quit nil)
  (mu4e-html2text-command 'mu4e-shr2text)
  :config
  (add-to-list 'mu4e-view-actions
               '("ViewInBrowser" . mu4e-action-view-in-browser) t))

;; (use-package pdf-tools
;;   :config
;;   (pdf-tools-install))

(use-package projectile
  :config
  (projectile-mode 1))

(use-package counsel-projectile
  :init
  ;; (setq projectile-keymap-prefix (kbd "C-c p"))
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  :config
  (counsel-projectile-mode 1))

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package expand-region
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))

;; C/C++
(use-package cmake-mode)
(use-package google-c-style
  :hook
  (c++-mode-hook . (lambda () (google-set-c-style))))
(use-package clang-format
  :config
  (setq clang-format-style "google")
  :init
  ;; (add-hook 'c++-mode-hook  (lambda () (add-hook 'before-save-hook 'clang-format-buffer)))
  )

;; Elixir
(use-package elixir-mode)
(use-package alchemist)
(use-package lua-mode)

;; Window management
(use-package ace-window
  :config
  (global-set-key (kbd "M-o") 'ace-window))

(use-package org
  :ensure org-plus-contrib
  :pin org
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda))
  :config
  (add-to-list 'org-modules 'org-drill)
  (add-to-list 'org-latex-packages-alist '("" "bm" t))
  (add-to-list 'org-latex-packages-alist '("" "listings" t))
  (add-to-list 'org-latex-packages-alist '("" "clrscode3e" t))
  (add-to-list 'org-latex-packages-alist '("" "tikz" t))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (python . t)
     (shell . t)))
  (setq org-default-notes-file "~/Dropbox/org/refile.org"
        org-startup-indented t
        org-confirm-babel-evaluate nil
        org-hide-leading-stars t
        org-latex-prefer-user-labels t
        ;; org-bullets-bullet-list '(" ")
        ;; org-ellipsis "  "
        ;; org-pretty-entities t
        org-hide-emphasis-markers t
        ;; org-agenda-block-separator ""
        org-fontify-whole-heading-line t
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t
        org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                            (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))
        org-deadline-warning-days 365
        org-agenda-dim-blocked-tasks nil
        org-agenda-compact-blocks t
        org-capture-templates '(("n" "note" entry (file org-default-notes-file)
                                 "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
                                ("j" "Journal" entry (file+datetree "~/org/tfg/journal.org") "* %? %^g\n " :time-prompt t)
                                ("p" "Project" entry (file+headline "~/org/todo.org" "Projects")
                                 (file "~/.emacs.d/org/template/new_project.org")))
        org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
                             ("~/gtd/someday.org" :level . 1)
                             ("~/gtd/tickler.org" :maxlevel . 2))))

;; (use-package org-bullets
;;   :config
;;   (org-bullets-mode))

(use-package org-ref
  :config
  (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f")))

(use-package olivetti)
;; (use-package poet-theme)
(use-package auctex
  :defer t
  :init
  (add-hook 'LaTeX-mode-hook
            (lambda()
              (setq TeX-auto-save t)
              (setq TeX-view-program-selection '((output-pdf "Zathura")))
              (add-to-list 'TeX-command-list
		                       '("tex-shell-escape" "pdflatex -shell-escape %s" TeX-run-command t t :help "Run foo") t)
              (setq TeX-command-default "tex-shell-escape"))))


;; (use-package pipenv
;;   :hook (python-mode . pipenv-mode)
;;   :init
;;   (setq
;;    pipenv-projectile-after-switch-function
;;    #'pipenv-projectile-after-switch-extended))

(use-package avy
  :config
  (global-set-key (kbd "M-t") 'avy-goto-word-1))

(use-package yaml-mode)
(use-package org-pomodoro)
(use-package org-super-agenda)
