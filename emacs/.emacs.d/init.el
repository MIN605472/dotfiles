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

(fset 'yes-or-no-p 'y-or-n-p)

;; gdb
(setq gdb-many-windows t
      gdb-show-main t)

(setq sentence-end-double-space nil)
(subword-mode)

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

;; (use-package all-the-icons)

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
  :bind (("C-x r a" . 'counsel-register)
         ("C-c j" . 'counsel-git-grep)
         ("C-c k" . 'counsel-ag))
  :config
  (ivy-mode 1)
  (counsel-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "[%d/%d] "))

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
    (face-remap-add-relative 'variable-pitch :family "Bembo Std"
                             :height 1.1))
  (add-hook 'nov-mode-hook 'my-nov-font-setup))


;; (use-package graphql)

;; dired
(setq dired-listing-switches "-aBhlt --group-directories-first")

;; (use-package evil
;;   :config
;;   (evil-mode 1))

(require 'mu4e)
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

(use-package pdf-tools
  :config
  (pdf-tools-install))

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

(defun mine-counsel-org-goto-all ()
  (interactive)
  (dolist (file (directory-files-recursively org-roam-directory ".*\.org$"))
    (find-file-noselect file))  
  (let (entries)
    (dolist (b (buffer-list))
      (with-current-buffer b
        (when (derived-mode-p 'org-mode)
          (setq entries
                (nconc entries
                       (counsel-outline-candidates 
                        '(:outline-title counsel-outline-title-org :display-style 'title)
                        )
                       
                       )))))
    (ivy-read "Goto: " entries
              :history 'counsel-org-link-history
              :action #'counsel-org-link-action2
              :caller 'mine-counsel-org-goto-all)))

(defun counsel-org-link-action2 (x)
  (let ((id (with-current-buffer (marker-buffer (cdr x))
              ;; (org-goto-marker-or-bmk (cdr x))
              (goto-char (cdr x))
              (org-id-get-create))))
    (org-insert-link nil (concat "id:" id) (car x))))

(defun counsel-org-link-local ()
  "Insert a link to an headline with completion."
  (interactive)
  (ivy-read "Link: " (counsel-outline-candidates
                      '(:outline-title counsel-outline-title-org :display-style 'title))
            :action #'counsel-org-link-action
            :history 'counsel-org-link-history
            :caller 'counsel-org-link))

(add-to-list 'default-frame-alist
             '(font . "Iosevka 12"))
;; (set-face-attribute 'variable-pitch nil :family "Libre Baskerville" :height 1.0)
(set-face-attribute 'default nil :family "Iosevka" :height 120 :weight 'regular)
(set-face-attribute 'fixed-pitch nil :family "DejaVu Sans Mono" :height 110)
;; (set-face-attribute 'variable-pitch nil :family "Spectral" :height 130)
(set-face-attribute 'variable-pitch nil :family "IBM Plex Serif" :height 130)
(use-package org
  :ensure org-plus-contrib
  :pin org
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda)
         ("C-c l s" . org-store-link)
         ("C-c l l h" . counsel-org-link-local)
         ("C-c l l H" .  mine-counsel-org-goto-all))
  :hook ((org-mode . visual-line-mode)
         (org-mode . flyspell-mode)
         (org-mode . org-bullets-mode)
         (org-mode . (lambda()
                       (olivetti-mode)
                       (olivetti-set-width 110)))
         (org-mode . (lambda () (org-indent-mode -1)))
         ;; (org-mode . variable-pitch-mode)
         (org-mode . (lambda ()
                       (setq org-preview-latex-image-directory "~/Pictures/ltximg/")
                       (org-latex-preview '(16))))
         ;; (org-mode . (lambda ()
         ;;               (texfrag-mode)
         ;;               (texfrag-document)))
         )
  :config
  ;; (org-indent-mode -1)
  (add-to-list 'org-modules 'org-drill)
  (add-to-list 'org-latex-packages-alist '("" "bm" t))
  (add-to-list 'org-latex-packages-alist '("" "listings" t))
  (add-to-list 'org-latex-packages-alist '("" "clrscode3e" t))
  (add-to-list 'org-latex-packages-alist '("" "tikz" t))
  (add-to-list 'org-latex-packages-alist '("" "pgf" t))
  (add-to-list 'org-latex-packages-alist '("" "blkarray" t))
  (add-to-list 'org-latex-packages-alist '("" "bbm" t))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((latex . t)
     (python . t)
     (shell . t)))
  (setq org-image-actual-width nil)
  ;; fix color handling in org-preview-latex-fragment
  (let ((dvipng--plist (alist-get 'dvipng org-preview-latex-process-alist)))
    (plist-put dvipng--plist :use-xcolor t)
    (plist-put dvipng--plist :image-converter '("dvipng -D %D -T tight -o %O %f")))
  
  (setq org-default-notes-file "~/Dropbox/org/refile.org"
        org-drill-add-random-noise-to-intervals-p t
        org-startup-indented t
        org-confirm-babel-evaluate nil
        org-hide-leading-stars t
        org-indent-indentation-per-level 1
        org-adapt-indentation nil
        org-latex-prefer-user-labels t
        org-id-link-to-org-use-id t
        org-bullets-bullet-list '("#")
        ;; org-ellipsis "⤵"
        ;; org-pretty-entities t
        org-hide-emphasis-markers t
        org-agenda-start-on-weekday 1
        calendar-week-start-day 1
        ;; org-agenda-files '("~/Dropbox/org/")
        org-agenda-block-separator ""
        org-fontify-whole-heading-line t
        org-fontify-done-headline t
        org-startup-folded nil
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

(use-package org-bullets)

(use-package org-ref
  :config
  (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f")))

(use-package org-drill
  :config
  (setq org-drill-scope 'file))

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

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph    
(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))

(define-key global-map "\M-Q" 'unfill-paragraph)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.3))
(use-package jsx-mode)
(use-package scala-mode)


(setq reftex-default-bibliography '("~/Dropbox/bibliography/references.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
      org-ref-default-bibliography '("~/Dropbox/bibliography/references.bib")
      org-ref-pdf-directory "~/Dropbox/bibliography/bibtex_pdfs/")
(setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))


(use-package deft
  ;; :bind ("C-c d" . deft)
  ;; :commands (deft)
  :custom
  (deft-directory "~/Dropbox/org")
  (deft-recursive t)
  (deft-extensions '("org" "md" "txt")))

(use-package zetteldeft
  :after deft)
  ;; :bind (("C-c d n" . zetteldeft-new-file)
  ;;        ("C-c d N" . zetteldeft-new-file-and-link)
  ;;        ("C-c d i" . zetteldeft-find-file-id-insert)
  ;;        ("C-c d d" . 'deft)
  ;;        ("C-c d D" . 'zetteldeft-deft-new-search)
  ;;        ("C-c d R" . 'deft-refresh)
  ;;        ("C-c d s" . 'zetteldeft-search-at-point)
  ;;        ("C-c d c" . 'zetteldeft-search-current-id)
  ;;        ("C-c d f" . 'zetteldeft-follow-link)
  ;;        ("C-c d F" . 'zetteldeft-avy-file-search-ace-window)
  ;;        ("C-c d l" . 'zetteldeft-avy-link-search)
  ;;        ("C-c d t" . 'zetteldeft-avy-tag-search)
  ;;        ("C-c d T" . 'zetteldeft-tag-buffer)
  ;;        ("C-c d i" . 'zetteldeft-find-file-id-insert)
  ;;        ("C-c d I" . 'zetteldeft-find-file-full-title-insert)
  ;;        ("C-c d o" . 'zetteldeft-find-file)
  ;;        ("C-c d n" . 'zetteldeft-new-file)
  ;;        ("C-c d N" . 'zetteldeft-new-file-and-link)
  ;;        ("C-c d r" . 'zetteldeft-file-rename)
  ;;        ("C-c d x" . 'zetteldeft-count-words)))

(use-package org-roam
  :hook 
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory "~/Dropbox/org")
  :bind (:map org-roam-mode-map
              (("C-c d l" . org-roam)
               ("C-c d d" . 'deft)
               ("C-c d f" . org-roam-find-file)
               ("C-c d g" . org-roam-show-graph))
              :map org-mode-map
              (("C-c d i" . org-roam-insert))))


;; Other themes: kaolin-themes, ample-theme, doom-themes
(use-package doom-themes
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(use-package modus-themes
  :config
  (setq modus-themes-links 'underline-only
        modus-themes-mode-line 'borderless
        modus-themes-headings
        '((1 . rainbow-section)
          (2 . rainbow-section)
          (3 . rainbow-section)
          (t . rainbow-section))))

(use-package poet-theme
  :config
  (setq poet-theme-variable-headers nil))

(load-theme 'modus-vivendi t)
;; fix theme when frame created by emacsclient
(add-hook 'after-make-frame-functions
            (lambda (frame)
              (select-frame frame)
              (load-theme 'modus-vivendi t)))

(use-package org-download)

;; (defvar bootstrap-version)
;; (let ((bootstrap-file
;;        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;;       (bootstrap-version 5))
;;   (unless (file-exists-p bootstrap-file)
;;     (with-current-buffer
;;         (url-retrieve-synchronously
;;          "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
;;          'silent 'inhibit-cookies)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp)))
;;   (load bootstrap-file nil 'nomessage))

(use-package hyperbole)
;; (use-package interleave)
(use-package org-noter
  :bind (("C-c n p" . org-noter-insert-precise-note)
         ("C-c n i" . org-noter-insert-note)))
(use-package vue-mode)
(use-package texfrag
  :custom
  (texfrag-subdir (file-name-as-directory (concat temporary-file-directory (make-temp-name "texfrag"))))
  (texfrag-header-default
"\\documentclass{article}
\\usepackage{amsmath,amsfonts}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{bm}
\\usepackage{listings}
\\usepackage{clrscode3e}
\\usepackage{tikz}
\\usepackage{pgf}
\\usepackage{blkarray}
\\usepackage{bbm}")
  :config
  (texfrag-global-mode)
  )
